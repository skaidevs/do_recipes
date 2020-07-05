import 'package:daisyinthekitchen/providers/recipes.dart';
import 'package:daisyinthekitchen/widgets/recipe_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _recipeNotifier = Provider.of<RecipeNotifier>(
      context,
    );
    final _recipes = _recipeNotifier.recipeItems;

    return GridView.builder(
      itemCount: _recipes.length,
      itemBuilder: (context, index) => ChangeNotifierProvider(
        create: (context) => _recipes[index],
        child: RecipeGridItem(
            /*id: _recipes[index].id,
          title: _recipes[index].title,
          time: _recipes[index].time,
          imageUrl: _recipes[index].imageUri,*/
            ),
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
