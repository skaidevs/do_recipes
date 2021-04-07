import 'package:cached_network_image/cached_network_image.dart';
import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/html_viewer.dart';
import 'package:dorecipes/widgets/serves_button.dart';
import 'package:dorecipes/widgets/time_cal_difficulty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  static const routeName = '/recipe_detail';

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  void fitchActiveServe() {
    Future.delayed(
      Duration.zero,
    ).then((_) async {
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
    /* final dao = Provider.of<dynamic>(
      context,
      listen: false,
    );*/
    /*final daoIng = Provider.of<RecipeIngredientDao>(
      context,
      listen: false,
    );*/

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).accentColor, //change your color here
            ),
            actions: <Widget>[
              /*StreamBuilder<bool>(
                  stream: dao.isDownloaded(_loadedRecipe.id),
                  builder: (context, AsyncSnapshot snapshot) =>
                      snapshot.hasData && snapshot.data
                          ? IconButton(
                              onPressed: () {
                                dao.deleteDownloadRecipe(
                                  _recipeId,
                                );
                                kFlutterToast(
                                    context: context,
                                    msg: 'Removed from recipe book');
                              },
                              icon: Icon(
                                Icons.library_books,
                                color: kColorGrey,
                              ),
                            )
                          : IconButton(
                              onPressed: () async {
                                */ /* _insertRecipe(
                                    loadedRecipe: _loadedRecipe,
                                    recipeNotifier: _recipeNotifier,
                                    dao: dao);*/ /*
                              },
                              icon: Icon(
                                Icons.library_books,
                                //color: Colors.grey,
                              ),
                            )),*/
              /*StreamBuilder<bool>(
                stream: daoIng.isDownloaded(_loadedRecipe.id),
                builder: (context, AsyncSnapshot snapshot) =>
                    snapshot.hasData && snapshot.data
                        ? IconButton(
                            onPressed: () {
                              daoIng.deleteDownloadRecipe(
                                _recipeId,
                              );

                              kFlutterToast(
                                  context: context,
                                  msg: 'Removed from shopping list');
                            },
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: kColorGrey,
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              // int _activeServe = _recipeNotifier.activeServe;
                              // print('Active Serve $_activeServe');

                              */ /*_insertIngredient(
                                  dao: daoIng,
                                  recipeNotifier: _recipeNotifier,
                                  loadedRecipe: _loadedRecipe);*/ /*
                              //Navigator.of(context).pushNamed(EditRecipe.routeName);
                            }),
              ),*/

              IconButton(
                onPressed: () {
                  print('Saved Ingredient');

                  DBHelper.insertIngredients(
                    data: _loadedRecipe,
                  );
                  kFlutterToast(
                      context: context, msg: 'Removed from shopping list');
                },
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: kColorTeal,
                ),
              ),
            ],
            expandedHeight: 360.0,
            floating: false,
            pinned: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            collapsedHeight: 130.0,
            flexibleSpace: CachedNetworkImage(
              imageUrl: _loadedRecipe.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //scale: 1.0,
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(
                          0.7,
                        ) /*kColorTeal.withOpacity(
                        0.1,
                      )*/
                        ,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(
                            2.0,
                          ),
                          topRight: Radius.circular(
                            70.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12.0,
                          left: 12.0,
                          right: 20.0,
                          top: 12.0,
                        ),
                        child: Text(
                          _loadedRecipe.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kColorWhite,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    /*Container(
                      height: 300.0,
                      width: double.infinity,
                      child: Image.network(
                        addHttps(_loadedRecipe.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),*/
                    const SizedBox(
                      height: 12.0,
                    ),
                    /*Center(
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
                    ),*/
                    Padding(
                      padding: const EdgeInsets.all(
                        16.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TimeCalDifficulty(loadedRecipe: _loadedRecipe),
                          const SizedBox(
                            height: 18,
                          ),

                          kRecipeTexts(text: 'Ingredients'),
                          //Ingredient
                          const SizedBox(
                            height: 6.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FittedBox(
                                  child: Text(
                                    'Serves ${_recipeNotifier.activeServe + 1}',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: kColorTeal,
                                      fontWeight: FontWeight.w700,
                                      // color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    ServesButton(
                                      onTap: () {
                                        _recipeNotifier
                                            .slideToPrev(_loadedRecipe);
                                        setState(() {});
                                      },
                                      iconData: Icons.remove,
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    ServesButton(
                                      onTap: () {
                                        _recipeNotifier
                                            .slideToNext(_loadedRecipe);
                                        setState(() {});
                                      },
                                      iconData: Icons.add,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _loadedRecipe
                                  .ingredients[_recipeNotifier.activeServe]
                                  .map<Widget>(
                                    (eachServes) => Text(
                                      '$eachServes',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                  .toList(),
                            ),
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
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: kColorTeal.withOpacity(
                                        0.1,
                                      ),
                                      /*boxShadow: [
                                        BoxShadow(
                                          blurRadius: 1.0,
                                          color: kColorTeal.withOpacity(
                                            0.1,
                                          ),
                                        ),
                                      ],*/
                                      borderRadius: BorderRadius.circular(
                                        8.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        12.0,
                                      ),
                                      child: Text(
                                        _loadedRecipe.preparation,
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: kColorTeal,
                                        ),
                                      ),
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
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }

  /*void _insertIngredient({
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
  }*/

  /*void _insertRecipe({
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
  }*/
}
