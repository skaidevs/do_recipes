import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/providers/recipe_by_category.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/empty_and_error_recipe.dart';
import 'package:dorecipes/widgets/loading_info.dart';
import 'package:dorecipes/widgets/recipe_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<AllRecipeNotifier>(builder: (context, notifier, _) {
        /*if (notifier.isLoading) {
            return Center(
              child: LoadingInfo(),
            );
          }
          if (notifier.error.isNotEmpty) {
            return Center(
              child: Error(
                text: 'An Error Occurred!!',
              ),
            );
          }
          if (notifier.allRecipeData == null) {
            return const Empty(
              text: 'No Recipe to Show',
            );
          }
          if (notifier.allRecipeData.isEmpty) {
            return const Empty(
              text: 'No Recipe to Show',
            );
          } else {*/
        return RecipeGrid(
          notifier: notifier,
        );
      }
          /*  },*/
          ),
    );
  }
}

class AllRecipeByCategory extends StatelessWidget {
  static const routeName = '/all_recipe_byCategory';

  @override
  Widget build(BuildContext context) {
    final _categoryName = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${_categoryName['name']}",
          style: TextStyle(fontFamily: kBalooTamma2),
        ),
      ),
      body: Container(
        child: Consumer<RecipeByCategoryNotifier>(
          builder: (context, notifier, _) {
            if (notifier.isLoading) {
              return Center(
                child: LoadingInfo(),
              );
            }

            if (notifier.error.isNotEmpty) {
              return Center(
                child: ErrorPage(
                  text: 'An Error Occurred!!',
                ),
              );
            }

            if (notifier.recipeDataByCategory == null) {
              return Empty(
                text: 'No Recipe to Show',
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
