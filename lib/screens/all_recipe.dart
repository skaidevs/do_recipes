import 'package:daisyinthekitchen/providers/all_recipe.dart';
import 'package:daisyinthekitchen/providers/recipe_by_category.dart';
import 'package:daisyinthekitchen/widgets/empty_recipe.dart';
import 'package:daisyinthekitchen/widgets/loading_info.dart';
import 'package:daisyinthekitchen/widgets/recipe_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<AllRecipeNotifier>(
        builder: (context, notifier, _) {
          if (notifier.isLoading) {
            return Center(
              child: LoadingInfo(),
            );
          }

          if (notifier.allRecipeData.isEmpty) {
            return Empty(
              text: 'No Recipe to Show',
            );
          } else {
            return RecipeGrid(
              notifier: notifier,
            );
          }
        },
      ),
    );
  }
}

class AllRecipeByCategory extends StatelessWidget {
  static const routeName = '/all_recipe_byCategory';

  @override
  Widget build(BuildContext context) {
    final _categoryName = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryName),
      ),
      body: Container(
        child: Consumer<RecipeByCategoryNotifier>(
          builder: (context, notifier, _) {
            if (notifier.isLoading) {
              return Center(
                child: LoadingInfo(),
              );
            }
            if (notifier.recipeDataByCategory.isEmpty) {
              return Empty(
                text: 'No Recipe to Show',
              );
            } else {
              return RecipeGridByCategory(
                notifier: notifier,
              );
            }
          },
        ),
      ),
    );
  }
}
