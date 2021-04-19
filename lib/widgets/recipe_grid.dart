import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/widgets/recipe_grid_item.dart';
import 'package:flutter/material.dart';

class RecipeGrid extends StatelessWidget {
  final List<Data> recipeList;

  const RecipeGrid({
    Key key,
    this.recipeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: recipeList.length,
      itemBuilder: (context, index) {
        final _data = recipeList[index];
        return GridItemCard(
          data: _data,
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        //mainAxisExtent: 200,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 9.0,
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }
}
