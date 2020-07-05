import 'package:daisyinthekitchen/providers/recipes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe_detail';
  @override
  Widget build(BuildContext context) {
    final _recipeId = ModalRoute.of(context).settings.arguments as String;
    final _loadedRecipe = Provider.of<RecipeNotifier>(
      context,
      listen: false,
    ).findRecipeById(
      _recipeId,
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('hI'),
      ),
    );
  }
}
