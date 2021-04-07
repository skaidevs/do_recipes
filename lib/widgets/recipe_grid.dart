import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/widgets/recipe_grid_item.dart';
import 'package:flutter/material.dart';

class RecipeGrid extends StatelessWidget {
  final List<Data> data;
  final String currentScreen;

  const RecipeGrid({Key key, this.data, this.currentScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final _data = data[index];
        return GridItemCard(
          data: _data,
          currentScreen: currentScreen,
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
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
