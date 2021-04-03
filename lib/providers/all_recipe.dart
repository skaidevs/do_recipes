import 'dart:convert';
import 'dart:math';

import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/category.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://recipes.trapcode.io/app/';

class AllRecipeNotifier with ChangeNotifier {
  Map<String, List<Data>> _cachedAllRecipe;
  Random random = Random();

  int _activeServe = 0;
  int get activeServe => _activeServe;
  set activeServe(int value) {
    if (value != activeServe) {
      _activeServe = value;
      notifyListeners();
    }
  }

  int currentRecipeIndex;

  List<Data> _allRecipeData = [];

  List<Data> get allRecipeData {
    return [..._allRecipeData];
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _recipeError = '';
  String get recipeError => _recipeError;

  String _internetConnectionError = '';
  String get internetConnectionError => _internetConnectionError;

  Data findAlbumById({String code}) {
    return _allRecipeData.firstWhere((id) => id.id == code);
  }

  Future initializeAllRecipe() async {
    return _initializeAllRecipe();
  }

  Future<List<Data>> updateAllRecipe() async {
    return _updateAllRecipe();
  }

  Data getRandomTodaysMenu() {}

  AllRecipeNotifier() : _cachedAllRecipe = Map() {
    _initializeAllRecipe().then((_) async {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<List<Data>> _initializeAllRecipe() async {
    _internetConnectionError = '';
    _recipeError = '';
    _isLoading = true;
    notifyListeners();
    return _allRecipeData = await _updateAllRecipe();
  }

  Future<List<Data>> _updateAllRecipe() async {
    final futureRecipe = await _getAllRecipe().catchError((onError) {
      print("SOMETHING IS WRONG IN ALL RECIPE. $onError");
      if (onError.toString().contains('SocketException')) {
        _internetConnectionError = 'error';
      }
      _isLoading = false;
      notifyListeners();
    });
    return futureRecipe;
  }

  Future<List<Data>> _getAllRecipe() async {
    final _id = '_id';
    if (!_cachedAllRecipe.containsKey(_id)) {
      final _allRecipeResponse = await http.get(
        Uri.parse('$baseUrl${'recipes'}'),
      );

      if (_allRecipeResponse.statusCode == 200) {
        var extractedData = json.decode(_allRecipeResponse.body);
        if (extractedData == null) {
          return null;
        }
        //print('DATA: ${extractedData.toString()}');

        Recipe _recipe = Recipe.fromJson(extractedData);
        print('DATA: ${_recipe.data[0].id}');
        _cachedAllRecipe[_id] = _recipe.data;
        notifyListeners();
      } else {
        _recipeError = _allRecipeResponse.body.toString();
        _isLoading = false;
        notifyListeners();
        throw RecipeError('Recipe could not be fetched. {{}} $_recipeError}');
      }
    }
    return _cachedAllRecipe[_id];
  }

  void slideToPrev(Data serve) {
    if (_activeServe > -serve.ingredients.length) {
      if (_activeServe <= 0) {
        return;
      }
      _activeServe--;
      notifyListeners();
    } else {
      return;
    }
  }

  void slideToNext(Data serve) {
    if (_activeServe < serve.ingredients.length - 1) {
      _activeServe++;
      notifyListeners();
    } else {
      return;
    }
  }
}
