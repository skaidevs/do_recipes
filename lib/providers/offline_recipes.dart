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

  String _dataID;
  String get dataID => _dataID;

  bool _isOffline = false;
  bool get isOffline => _isOffline;

  Data findRecipeById({String code}) {
    return _recipeList.firstWhere((id) => id.id == code, orElse: () => null);
  }

  Future<void> insertInToDataBase(Data data) async {
    final _id = findRecipeById(code: data.id)?.id;

    if (_id != null && _id == data.id) {
      print('Its favourite and removing it $data');
      deleteRecipeFromDb(recipeId: data.id);
    } else {
      print('Nothing found so inserting  $data');
      insertRecipeInToDb(recipeData: data);
    }
  }

  void _me(String id) {
    for (Data dataRecipe in _recipeList) {
      if (dataRecipe?.id == id) {
        //info?.progress = task.progress;
        notifyListeners();
        print('bindIsolate $id');
      }
    }
  }

  OfflineNotifier() {
    print('Init recipe offline');
    fetchAndSetRecipe();
  }
  /*OfflineNotifier() {
    print('Init recipe offline');
    fetchAndSetRecipe();
    _initializeIngredients();
  }

  Future _initializeRecipe() {
    print('Init recipe');
    fetchAndSetRecipe();
  }

  Future _initializeIngredients() {
    return fetchAndSetIngredients();
  }*/

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

  Future deleteRecipeFromDb({String recipeId}) {
    _recipeList.removeWhere((data) => data.id == recipeId);
    print("recipe delete.... ${_recipeList.length}");
    notifyListeners();
    return DBHelper.deleteRecipe(recipeId);
  }

  Future insertRecipeInToDb({Data recipeData}) {
    print("recipe inserting.... ${recipeData.id}");
    return DBHelper.insertRecipe(data: recipeData)
        .then((value) => fetchAndSetRecipe());
  }

  //final _dataList = await DBHelper.fetchRecipeData();

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
}
