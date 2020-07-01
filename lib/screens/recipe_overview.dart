import 'package:daisyinthekitchen/models/recipe.dart';
import 'package:daisyinthekitchen/widgets/recipe_grid_item.dart';
import 'package:flutter/material.dart';

class RecipeOverviewScreen extends StatelessWidget {
  final List<Recipe> loadedRecipe = [
    Recipe(
        id: '1',
        title: 'Sticky BBQ Chicken and Courgette Salad',
        time: '34 min',
        difficulty: 'NA',
        calories: '12',
        imageUri:
            'https://res.cloudinary.com/hellochef/image/upload/a_ignore,c_scale,dpr_2.0,f_auto,q_auto,w_1400/dxnrj1zztd3dyk2obgvm',
        ingredients: ['sugar', 'spice'],
        method: ['fry', 'dry']),
    Recipe(
        id: '2',
        title: 'Sticky BBQ Chicken and Courgette Salad',
        time: '34 min',
        difficulty: 'NA',
        calories: '12',
        imageUri:
            'https://res.cloudinary.com/hellochef/image/upload/a_ignore,c_scale,dpr_2.0,f_auto,q_auto,w_1400/dxnrj1zztd3dyk2obgvm',
        ingredients: ['sugar', 'spice'],
        method: ['fry', 'dry']),
    Recipe(
        id: '3',
        title: 'Sticky BBQ Chicken and Courgette Salad',
        time: '34 min',
        difficulty: 'NA',
        calories: '12',
        imageUri:
            'https://res.cloudinary.com/hellochef/image/upload/a_ignore,c_scale,dpr_2.0,f_auto,q_auto,w_1400/dxnrj1zztd3dyk2obgvm',
        ingredients: ['sugar', 'spice'],
        method: ['fry', 'dry']),
    Recipe(
        id: '4',
        title: 'Sticky BBQ Chicken and Courgette Salad',
        time: '34 min',
        difficulty: 'NA',
        calories: '12',
        imageUri:
            'https://res.cloudinary.com/hellochef/image/upload/a_ignore,c_scale,dpr_2.0,f_auto,q_auto,w_1400/dxnrj1zztd3dyk2obgvm',
        ingredients: ['sugar', 'spice'],
        method: ['fry', 'dry']),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: loadedRecipe.length,
        itemBuilder: (context, index) => RecipeGridItem(
          id: loadedRecipe[index].id,
          title: loadedRecipe[index].title,
          time: loadedRecipe[index].time,
          imageUrl: loadedRecipe[index].imageUri,
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
      ),
    );
  }
}
