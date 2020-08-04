import 'package:daisyinthekitchen/providers/all_recipe.dart';
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

          return RecipeGrid(
            notifier: notifier,
          );
        },
      ),
    );
  }
}
