import 'package:daisyinthekitchen/helpers/recipe_database.dart';
import 'package:daisyinthekitchen/providers/all_recipe.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:daisyinthekitchen/widgets/html_viewer.dart';
import 'package:daisyinthekitchen/widgets/serves_button.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' as v;
import 'package:provider/provider.dart';

class DownloadedRecipeDetailScreen extends StatefulWidget {
  static const routeName = '/downloaded_recipe_detail';

  @override
  _DownloadedRecipeDetailScreenState createState() =>
      _DownloadedRecipeDetailScreenState();
}

class _DownloadedRecipeDetailScreenState
    extends State<DownloadedRecipeDetailScreen> {
  int _activeServes = 0;
  @override
  void initState() {
    // TODO: implement initState
    //fitchActiveServe();
    super.initState();
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    DownloadRecipe _recipeId = ModalRoute.of(context).settings.arguments;
    final dao = Provider.of<RecipeDao>(
      context,
      listen: false,
    );

    final regExp = new RegExp(r'(?:\[)?(\[[^\]]*?\](?:,?))(?:\])?');
    final input = _recipeId.ingredients;
    final _ingredients = regExp
        .allMatches(input)
        .map((m) => m.group(1))
        .map((String item) => item.replaceAll(new RegExp(r'[\[\]]'), ''))
        .toList();

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          //title: Text(_pages[_bottomNavigation.currentIndex]['title']),
          actions: <Widget>[
            StreamBuilder<bool>(
              stream: dao.isDownloaded(_recipeId.code),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data) {
                  DownloadRecipe _recipe;

                  return IconButton(
                    onPressed: () {
                      dao.deleteDownloadRecipe(
                        _recipeId.code,
                      );
                      print('REMOVED ${_recipeId}');

                      kFlutterToast(
                          context: context, msg: 'Removed from Recipe Book');
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
                      loadedRecipe: _recipeId,
                      dao: dao,
                    );
                    print('ADDED');
                  },
                  icon: Icon(
                    Icons.library_books,
                    //color: Colors.grey,
                  ),
                );
              },
            ),
            IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  //Navigator.of(context).pushNamed(EditRecipe.routeName);
                }),
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  //Navigator.of(context).pushNamed(EditRecipe.routeName);
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300.0,
                width: double.infinity,
                child: Image.network(
                  _recipeId.imageUri,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Text(
                    '${_recipeId.title}',
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
                    //TimeCalDifficulty(loadedRecipe: _loadedRecipe),

                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Icon(
                                Icons.access_time,
                                size: 18,
                                color: kColorGrey,
                              ),
                            ),
                            Text(
                              '${_recipeId.duration}',
                              style: TextStyle(
                                fontFamily: kBalooTamma2,
                                color: kColorGrey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Icon(
                                Icons.show_chart,
                                size: 18,
                                color: kColorGrey,
                              ),
                            ),
                            Text(
                              '${_recipeId.calories} Cals',
                              style: TextStyle(
                                fontFamily: kBalooTamma2,
                                color: kColorGrey,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Icon(
                                Icons.grain,
                                size: 18,
                                color: kColorGrey,
                              ),
                            ),
                            Text(
                              '${capitalize(_recipeId.difficulty)} Difficulty',
                              style: TextStyle(
                                fontFamily: kBalooTamma2,
                                color: kColorGrey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

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
                              children: <Widget>[
                                Text(
                                  'Serves ${_activeServes + 1}',
                                  style: TextStyle(
                                    fontFamily: kBalooTamma2,
                                    fontSize: 18.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 18.0,
                                  ),
                                  child: ServesButton(
                                    onTap: () {
                                      if (_activeServes >
                                          -_ingredients.length) {
                                        print('slideToPrev $_activeServes');
                                        if (_activeServes <= 0) {
                                          return;
                                        }
                                        _activeServes--;
                                      } else {
                                        return;
                                      }
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
                                      print(
                                          'slideToNext: ${_ingredients.length}');
                                      if (_activeServes <
                                          _ingredients.length - 1) {
                                        _activeServes++;
                                      } else {
                                        return;
                                      }
                                      setState(() {});
                                    },
                                    iconData: Icons.add,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _ingredients[_activeServes]
                          .split(', ')
                          .map<Widget>(
                            (eachServes) => Text(
                              '${eachServes.replaceAll(',', '')}',
                              style: TextStyle(
                                fontFamily: kBalooTamma2,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                          .toList(),
                    ),

                    _recipeId.preparation == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 6.0,
                            ),
                            child: kRecipeTexts(text: 'Preparation'),
                          ),
                    _recipeId.preparation == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: Text(
                              _recipeId.preparation,
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
                      data: _recipeId.method,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _insertRecipe({
    DownloadRecipe loadedRecipe,
    AllRecipeNotifier recipeNotifier,
    RecipeDao dao,
  }) {
    final recipeDownload = DownloadRecipesCompanion(
      code: v.Value(loadedRecipe.code),
      title: v.Value(loadedRecipe.title),
      imageUri: v.Value(loadedRecipe.imageUri),
      calories: v.Value(loadedRecipe.calories),
      duration: v.Value(loadedRecipe.duration),
      dueData: v.Value(DateTime.now()),
      difficulty: v.Value(loadedRecipe.difficulty),
      method: v.Value(loadedRecipe.method),
      preparation: v.Value(loadedRecipe.preparation),
      ingredients: v.Value(
        loadedRecipe.ingredients.toString(),
      ),
    );
    dao.insertDownloadRecipe(recipeDownload).then((_) {
      kFlutterToast(context: context, msg: 'Add To Recipe Book');
    });
  }
}
