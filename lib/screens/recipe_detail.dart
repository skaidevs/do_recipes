import 'package:daisyinthekitchen/providers/recipes.dart';
import 'package:daisyinthekitchen/widgets/circle_button.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:daisyinthekitchen/widgets/time_cal_difficulty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe_detail';
  @override
  Widget build(BuildContext context) {
    final _recipeId = ModalRoute.of(context).settings.arguments as String;
    final _recipeNotifier = Provider.of<RecipeNotifier>(
      context,
      listen: false,
    );
    final _loadedRecipe = _recipeNotifier.findRecipeById(
      _recipeId,
    );

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300.0,
              width: double.infinity,
              child: Image.network(
                _loadedRecipe.imageUri,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Text(
              '${_loadedRecipe.title}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
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
                    Column(
                      children: _loadedRecipe.ingredients
                          .map<Widget>(
                            (ingredient) => SizedBox(
                                width: double.infinity,
                                child: Text('$ingredient',
                                    textAlign: TextAlign.left)),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    kRecipeTexts(text: 'Preparation'),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    kRecipeTexts(text: 'Method'),
                    Column(
                      children: _loadedRecipe.method
                          .map<Widget>(
                            (ingredient) => SizedBox(
                              width: double.infinity,
                              child: Text('$ingredient',
                                  textAlign: TextAlign.left),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
