import 'package:daisyinthekitchen/models/recipe.dart';
import 'package:daisyinthekitchen/providers/all_recipe.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:daisyinthekitchen/widgets/html_viewer.dart';
import 'package:daisyinthekitchen/widgets/serves_button.dart';
import 'package:daisyinthekitchen/widgets/time_cal_difficulty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  static const routeName = '/recipe_detail';

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int _activeServe = 0;
//  void slideToPrev() {
//    var prevPage = this._activeServe - 1;
//    if (this.data.ingredients[prevPage]) {
//      this._activeServe--;
//    }
//  }

  void slideToNext({Data data, int active}) {
    var nextPage = active + 1;
    if (data.ingredients[nextPage]) {
      active++;
      print('Called ${active}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _recipeId = ModalRoute.of(context).settings.arguments as String;
    final _recipeNotifier = Provider.of<AllRecipeNotifier>(
      context,
      listen: false,
    );
    var _loadedRecipe = _recipeNotifier.findAlbumById(code: _recipeId);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        //title: Text(_pages[_bottomNavigation.currentIndex]['title']),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.library_books),
              onPressed: () {
                //Navigator.of(context).pushNamed(EditRecipe.routeName);
              }),
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
                _loadedRecipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Center(
              child: Text(
                '${_loadedRecipe.title}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TimeCalDifficulty(loadedRecipe: _loadedRecipe),

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
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
                                'Serves  10',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 18.0,
                                ),
                                child: ServesButton(
                                  onTap: () => print("reduce"),
                                  iconData: Icons.remove,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                child: ServesButton(
                                  onTap: () {
                                    _recipeNotifier.slideToNext();
                                    /*print('Called Button}');
                                    var nextPage =
                                        _recipeNotifier.activeServe + 1;
                                    if (nextPage <
                                        _loadedRecipe.ingredients.length) {
                                      */ /*_recipeNotifier.activeServe += 1;
                                      print(
                                          'Called ${_recipeNotifier.activeServe}');*/ /*
                                      setState(() {
                                        _recipeNotifier.activeServe += 1;

                                        print(
                                            'Called ${_recipeNotifier.activeServe}');
                                      });
                                    }*/
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

                  //TODO: recontruct

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _recipeNotifier.eachServes
                        .map<Widget>(
                          (eachServes) => Text('$eachServes',
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.left),
                        )
                        .toList(),
                  ),

//                  Text('${_recipeNotifier.eachServes}',
//                      style: TextStyle(fontSize: 16.0),
//                      textAlign: TextAlign.left),

                  /* ListView.builder(
                      //scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _loadedRecipe.ingredients.length,
                      itemBuilder: (context, index) {
                        var ing;
                        activeServe = index;

                        _loadedRecipe.ingredients.forEach((element) {
                          element.forEach((e) {
                            ing = e;

                            print('here!!!${ing}');
                          });
                        });

                        return Text('$ing',
                            style: TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.left);
                      }),*/

                  /* ListView.builder(
                    //scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _recipeNotifier.eachServes.length,
                    itemBuilder: (context, index) => Column(
                      children: _loadedRecipe.ingredients
                          .map<Widget>(
                            (ingredient) => SizedBox(
                              width: double.infinity,
                              child: Text('${ingredient[index]}',
                                  style: TextStyle(fontSize: 16.0),
                                  textAlign: TextAlign.left),
                            ),
                          )
                          .toList(),
                    ),


                  ),*/

                  _loadedRecipe.preparation == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10.0,
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
                              fontSize: 16.0,
                            ),
                          ),
                        ),

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
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
}
