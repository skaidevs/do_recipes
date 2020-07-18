import 'package:daisyinthekitchen/models/recipe.dart';
import 'package:flutter/foundation.dart';

class RecipeNotifier with ChangeNotifier {
  final List<Recipe> _recipeItems = [
    Recipe(
        id: '1',
        title: 'Sticky BBQ Chicken and Courgette Salad',
        time: '32 min',
        difficulty: 'NA',
        calories: '12',
        imageUri:
            'https://res.cloudinary.com/hellochef/image/upload/a_ignore,c_scale,dpr_2.0,f_auto,q_auto,w_1400/dxnrj1zztd3dyk2obgvm',
        ingredients: ['sugar', '1'],
        method: ['fry', 'dry']),
    Recipe(
        id: '2',
        title: 'Sticky BBQ Chicken and Courgette Salad',
        time: '34 min',
        difficulty: 'NA',
        calories: '12',
        imageUri:
            'https://res.cloudinary.com/hellochef/image/upload/a_ignore,c_scale,dpr_2.0,f_auto,q_auto,w_1400/dxnrj1zztd3dyk2obgvm',
        ingredients: ['sugar', '2'],
        method: ['fry', 'dry']),
    Recipe(
        id: '3',
        title: 'Sticky BBQ Chicken and Courgette Salad',
        time: '34 min',
        difficulty: 'NA',
        calories: '12',
        imageUri:
            'https://res.cloudinary.com/hellochef/image/upload/a_ignore,c_scale,dpr_2.0,f_auto,q_auto,w_1400/dxnrj1zztd3dyk2obgvm',
        ingredients: ['sugar', '3'],
        method: ['fry', 'dry']),
    Recipe(
        id: '4',
        title: 'Sticky BBQ Chicken and Courgette Salad',
        time: '34 min',
        difficulty: 'NA',
        calories: '12',
        imageUri:
            'https://res.cloudinary.com/hellochef/image/upload/a_ignore,c_scale,dpr_2.0,f_auto,q_auto,w_1400/dxnrj1zztd3dyk2obgvm',
        ingredients: ['sugar', '4'],
        method: ['fry', 'dry']),
  ];
  Recipe findRecipeById(String id) {
    return _recipeItems.firstWhere((recipe) => recipe.id == id);
  }

  List<Recipe> get recipeItems {
    return [..._recipeItems];
  }

  addRecipe() {
    //_recipeItems.add(value);
    notifyListeners();
  }
}
