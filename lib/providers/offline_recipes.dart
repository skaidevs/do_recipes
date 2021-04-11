import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class OfflineNotifier with ChangeNotifier {
  List<Data> _recipeList = [];
  List<Data> get recipeList {
    return [..._recipeList];
  }

  List<Data> _ingredientList = [];
  List<Data> get ingredientList {
    return [..._ingredientList];
  }

  Data findRecipeById({String code}) {
    return _recipeList.firstWhere((id) => id.id == code, orElse: () => null);
  }

  Data findIngredientById({String code}) {
    return _ingredientList.firstWhere((id) => id.id == code,
        orElse: () => null);
  }

  OfflineNotifier() {
    fetchAndSetRecipe();
    fetchAndSetIngredients();
  }

  Future<void> fetchAndSetRecipe() async {
    final _dataList = await DBHelper.fetchRecipeData();
    if (_dataList.length > 0) {
      //print("Fetching offline recipe list 1 ${_dataList[0].values}");
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

  Future<bool> insertAndRemoveRecipeFromDB(
    Data data,
    BuildContext context,
  ) async {
    final _id = findRecipeById(code: data.id)?.id;
    if (_id != null && _id == data.id) {
      deleteRecipeFromDb(recipeId: data.id);
      return true;
    } else {
      insertRecipeInToDb(recipeData: data);
      return false;
    }
  }

  Future<bool> insertAndRemoveIngFromDB(
    Data data,
    BuildContext context,
  ) async {
    final _id = findIngredientById(code: data.id)?.id;
    if (_id != null && _id == data.id) {
      deleteIngredientFromDb(recipeId: data.id);
      return true;
    } else {
      insertIngredientInToDb(recipeData: data);
      return false;
    }
  }

  Future insertRecipeInToDb({Data recipeData}) async {
    await DBHelper.insertRecipe(data: recipeData)
        .then((_) => fetchAndSetRecipe());
  }

  Future deleteRecipeFromDb({String recipeId}) {
    _recipeList.removeWhere((data) => data.id == recipeId);
    notifyListeners();
    return DBHelper.deleteRecipe(recipeId);
  }

  Future deleteAllRecipeFromDb() {
    _recipeList.clear();
    notifyListeners();
    return DBHelper.deleteAllRecipe();
  }

  Future<void> fetchAndSetIngredients() async {
    final _dataList = await DBHelper.fetchIngredientData();
    if (_dataList.length > 0) {
      //print("Fetching offline Ingredient list  ${_dataList[0].values}");
      _ingredientList = _dataList
          .map(
            (item) => Data.fromDb(item),
          )
          .toList();

      notifyListeners();
      // print("Fetching offline Ingredient list 2  ${_ingredientList[0].title}");

      return _ingredientList;
    }
    return null;
  }

  Future insertIngredientInToDb({Data recipeData}) async {
    await DBHelper.insertIngredients(data: recipeData)
        .then((_) => fetchAndSetIngredients());
  }

  Future deleteIngredientFromDb({String recipeId}) {
    _ingredientList.removeWhere((data) => data.id == recipeId);
    notifyListeners();
    return DBHelper.deleteIngredient(id: recipeId);
  }

  Future deleteAllIngredientFromDb() {
    _ingredientList.clear();
    notifyListeners();
    return DBHelper.deleteAllIngredient();
  }
}
