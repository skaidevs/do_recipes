import 'package:dorecipes/helpers/ingredient_database.dart';
import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/html_viewer.dart';
import 'package:dorecipes/widgets/serves_button.dart';
import 'package:dorecipes/widgets/time_cal_difficulty.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' as v;
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  static const routeName = '/recipe_detail';

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  void fitchActiveServe() {
    Future.delayed(Duration(seconds: 0)).then((_) async {
      Provider.of<AllRecipeNotifier>(context).activeServe = 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    //fitchActiveServe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _recipeId = ModalRoute.of(context).settings.arguments as String;
    final _recipeNotifier = Provider.of<AllRecipeNotifier>(
      context,
      listen: false,
    );
    Data _loadedRecipe = _recipeNotifier.findAlbumById(code: _recipeId);
    final dao = Provider.of<RecipeDao>(
      context,
      listen: false,
    );
    final daoIng = Provider.of<RecipeIngredientDao>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        //title: Text(_pages[_bottomNavigation.currentIndex]['title']),
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: dao.isDownloaded(_loadedRecipe.id),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data) {
                //DownloadRecipe _recipe;

                return IconButton(
                  onPressed: () {
                    dao.deleteDownloadRecipe(
                      _recipeId,
                    );

                    kFlutterToast(
                        context: context, msg: 'Removed from recipe book');
                  },
                  icon: Icon(
                    Icons.library_books,
                    color: kColorGrey,
                  ),
                );
              }

              return IconButton(
                onPressed: () async {
                  _insertRecipe(
                      loadedRecipe: _loadedRecipe,
                      recipeNotifier: _recipeNotifier,
                      dao: dao);
                },
                icon: Icon(
                  Icons.library_books,
                  //color: Colors.grey,
                ),
              );
            },
          ),
          StreamBuilder<bool>(
            stream: daoIng.isDownloaded(_loadedRecipe.id),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data) {
                //DownloadRecipe _recipe;

                return IconButton(
                  onPressed: () {
                    daoIng.deleteDownloadRecipe(
                      _recipeId,
                    );

                    kFlutterToast(
                        context: context, msg: 'Removed from shopping list');
                  },
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: kColorGrey,
                  ),
                );
              }

              return IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    // int _activeServe = _recipeNotifier.activeServe;
                    // print('Active Serve $_activeServe');

                    _insertIngredient(
                        dao: daoIng,
                        recipeNotifier: _recipeNotifier,
                        loadedRecipe: _loadedRecipe);
                    //Navigator.of(context).pushNamed(EditRecipe.routeName);
                  });
            },
          ),
          // IconButton(
          //     icon: Icon(Icons.share),
          //     onPressed: () {
          //       //Navigator.of(context).pushNamed(EditRecipe.routeName);
          //     })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300.0,
              width: double.infinity,
              child: Image.network(
                _loadedRecipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                ),
                child: Text(
                  '${_loadedRecipe.title}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontFamily: kBalooTamma2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TimeCalDifficulty(loadedRecipe: _loadedRecipe),

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 12.0,
                    ),
                    child: kRecipeTexts(text: 'Ingredients'),
                  ),
                  //Ingredient
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 12.0,
                        bottom: 16.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  'Serves ${_recipeNotifier.activeServe + 1}',
                                  style: TextStyle(
                                    fontFamily: kBalooTamma2,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18.0,
                                    ),
                                    child: ServesButton(
                                      onTap: () {
                                        _recipeNotifier
                                            .slideToPrev(_loadedRecipe);
                                        setState(() {});
                                      },
                                      iconData: Icons.remove,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                    ),
                                    child: ServesButton(
                                      onTap: () {
                                        _recipeNotifier
                                            .slideToNext(_loadedRecipe);
                                        setState(() {});
                                      },
                                      iconData: Icons.add,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        _loadedRecipe.ingredients[_recipeNotifier.activeServe]
                            .map<Widget>(
                              (eachServes) => Text(
                                '$eachServes',
                                style: TextStyle(
                                  fontFamily: kBalooTamma2,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                            .toList(),
                  ),

                  _loadedRecipe.preparation == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 6.0,
                          ),
                          child: kRecipeTexts(text: 'Preparation'),
                        ),
                  _loadedRecipe.preparation == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Text(
                            _loadedRecipe.preparation,
                            style: TextStyle(
                              fontFamily: kBalooTamma2,
                              fontSize: 18.0,
                            ),
                          ),
                        ),

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 6.0,
                    ),
                    child: kRecipeTexts(text: 'Method'),
                  ),

                  HtmlViewer(
                    data: _loadedRecipe.method,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insertIngredient({
    Data loadedRecipe,
    AllRecipeNotifier recipeNotifier,
    RecipeIngredientDao dao,
  }) {
    final ingredientDownload = DownloadRecipeIngredientCompanion(
      code: v.Value(loadedRecipe.id),
      title: v.Value(loadedRecipe.title),
      ingredients: v.Value(
        loadedRecipe.ingredients.toString(),
      ),
    );
    dao.insertIngredient(ingredientDownload).then((_) {
      kFlutterToast(context: context, msg: 'Added to shopping list');
    });
  }

  void _insertRecipe({
    Data loadedRecipe,
    AllRecipeNotifier recipeNotifier,
    RecipeDao dao,
  }) {
    var _ingredients = loadedRecipe.ingredients.toString();

    final recipeDownload = DownloadRecipesCompanion(
      code: v.Value(loadedRecipe.id),
      title: v.Value(loadedRecipe.title),
      imageUri: v.Value(loadedRecipe.imageUrl),
      calories: v.Value(loadedRecipe.calories),
      duration: v.Value(loadedRecipe.duration),
      dueData: v.Value(DateTime.now()),
      difficulty: v.Value(loadedRecipe.difficulty),
      method: v.Value(loadedRecipe.method),
      preparation: v.Value(loadedRecipe.preparation),
      ingredients: v.Value(
        _ingredients,
      ),
    );
    dao.insertDownloadRecipe(recipeDownload).then((_) {
      kFlutterToast(context: context, msg: 'Added to recipe book');
    });
  }
}
