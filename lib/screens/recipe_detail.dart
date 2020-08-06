import 'package:daisyinthekitchen/providers/all_recipe.dart';
import 'package:daisyinthekitchen/widgets/circle_button.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:daisyinthekitchen/widgets/time_cal_difficulty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe_detail';
  @override
  Widget build(BuildContext context) {
    final _recipeId = ModalRoute.of(context).settings.arguments as String;
    final _recipeNotifier = Provider.of<AllRecipeNotifier>(
      context,
      listen: false,
    );
    final _loadedRecipe = _recipeNotifier.findAlbumById(code: _recipeId);

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
                  SizedBox(
                    height: 16.0,
                  ),
                  kRecipeTexts(text: 'Ingredients'),
                  //Ingredient
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
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
                                child: CircleButton(
                                  onTap: () => print("reduce"),
                                  iconData: Icons.remove,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                child: CircleButton(
                                  onTap: () => print("add"),
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
                  /* Container(
                    height: 130,
                    child: ListView.builder(
                      itemCount: _loadedRecipe.ingredients.length,
                      itemBuilder: (context, index) => Card(
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Text(
                            _loadedRecipe.ingredients[index].toString(),
                          ),
                        ),
                      ),
                    ),
                  ),*/
                  Column(
                    children: _loadedRecipe.ingredients
                        .map<Widget>(
                          (ingredient) => SizedBox(
                            width: double.infinity,
                            child: Text('${ingredient[0]}',
                                textAlign: TextAlign.left),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _loadedRecipe.preparation == null
                      ? Container()
                      : kRecipeTexts(text: 'Preparation'),
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
                  Text(
                    'Method',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  //kRecipeTexts(text: 'Method'),
                  Html(
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
