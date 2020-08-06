import 'package:daisyinthekitchen/providers/all_recipe.dart';
import 'package:daisyinthekitchen/providers/recipe_by_category.dart';
import 'package:daisyinthekitchen/widgets/recipe_grid_item.dart';
import 'package:flutter/material.dart';

class RecipeGrid extends StatelessWidget {
  final AllRecipeNotifier notifier;
  const RecipeGrid({Key key, this.notifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: notifier.allRecipeData.length,
      itemBuilder: (context, index) => RecipeGridItem(
        id: notifier.allRecipeData[index].id,
        title: notifier.allRecipeData[index].title,
        duration: notifier.allRecipeData[index].duration,
        imageUrl: notifier.allRecipeData[index].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3.4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      padding: const EdgeInsets.all(4.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }
}

class RecipeGridByCategory extends StatelessWidget {
  final RecipeByCategoryNotifier notifier;
  const RecipeGridByCategory({Key key, this.notifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: notifier.recipeDataByCategory.length,
      itemBuilder: (context, index) => RecipeGridItem(
        id: notifier.recipeDataByCategory[index].id,
        title: notifier.recipeDataByCategory[index].title,
        duration: notifier.recipeDataByCategory[index].duration,
        imageUrl: notifier.recipeDataByCategory[index].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3.4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      padding: const EdgeInsets.all(4.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }
}
