import 'package:dorecipes/providers/offline_recipes.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/empty_and_error_recipe.dart';
import 'package:dorecipes/widgets/loading_info.dart';
import 'package:dorecipes/widgets/recipe_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeBook extends StatefulWidget {
  @override
  _RecipeBookState createState() => _RecipeBookState();
}

class _RecipeBookState extends State<RecipeBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe Book',
          style: TextStyle(
            color: kColorTeal,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<OfflineNotifier>(
          context,
          listen: false,
        ).fetchAndSetRecipe(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? LoadingInfo()
                : Consumer<OfflineNotifier>(
                    child: Empty(
                      text: 'Recipe Book is Empty.\n Start Adding!',
                    ),
                    builder: (context, notifier, child) =>
                        notifier.recipeList.length <= 0
                            ? child
                            : RecipeGrid(
                                data: notifier.recipeList,
                                currentScreen: 'recipe_book',
                              ),
                  ),
      ),
    );
  }
}
