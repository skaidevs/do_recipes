import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:flutter/foundation.dart';

class OfflineNotifier with ChangeNotifier {
  List<Data> _recipeList = [];
  List<Data> get recipeList {
    return [..._recipeList];
  }

  List<Data> _ingredientList = [];
  List<Data> get ingredientList {
    return [..._ingredientList];
  }

  Future<void> fetchAndSetRecipe() async {
    final _dataList = await DBHelper.fetchRecipeData();

    _recipeList = _dataList
        .map(
          (item) => Data.fromDb(item),
        )
        .toList();

    print("Fetching offline recipe list ${_dataList.length}");

    notifyListeners();
  }

  Future<List<Data>> fetchAndSetIngredients() async {
    final _dataList = await DBHelper.fetchIngredientData();
    if (_dataList.length > 0) {
      print("Fetching offline recipe list ${_dataList.length}");
      _recipeList = _dataList
          .map(
            (item) => Data.fromDb(item),
          )
          .toList();
      notifyListeners();
      return _recipeList;
    }

    return null;
  }
}
