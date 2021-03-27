import 'dart:collection';
import 'dart:convert';

import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/category.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://recipes.trapcode.io/app/';

class AllRecipeNotifier with ChangeNotifier {
  Map<String, List<Data>> _cachedAllRecipe;

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
  String error = '';

  UnmodifiableListView<Data> get allRecipeData =>
      UnmodifiableListView(_allRecipeData);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    if (value != isLoading) {
      _isLoading = value;
      notifyListeners();
    }
  }

  Data findAlbumById({String code}) {
    return _allRecipeData.firstWhere((id) => id.id == code);
  }

  Future initializeAllRecipe() async {
    return _initializeAllRecipe();
  }

  Future<List<Data>> updateAllRecipe() async {
    return _updateAllRecipe();
  }

  AllRecipeNotifier() : _cachedAllRecipe = Map() {
    _initializeAllRecipe().then((_) async {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future _initializeAllRecipe() async {
    return _allRecipeData = await _updateAllRecipe();
  }

  Future<List<Data>> _updateAllRecipe() async {
    _isLoading = true;
    notifyListeners();
    final futureRecipe = await _getAllRecipe().catchError((onError) {
      print("SOMETHING IS WRONG IN ALL RECIPE. $onError");
      _isLoading = false;
      notifyListeners();
    });
    return futureRecipe;
  }

  Future<List<Data>> _getAllRecipe() async {
    String _id = '_id';

    if (!_cachedAllRecipe.containsKey(_id)) {
      final _allRecipeResponse = await http.get(
        Uri.parse('$baseUrl${'recipes'}'),
      );

      print(_allRecipeResponse.body);
      if (_allRecipeResponse.statusCode == 200) {
        var extractedData = json.decode(_allRecipeResponse.body);
        if (extractedData == null) {
          return null;
        }

        Recipe _recipe = Recipe.fromJson(extractedData);
        _cachedAllRecipe[_id] = _recipe.data;
        notifyListeners();
      } else {
        error = _allRecipeResponse.body.toString();
        throw RecipeError('Recipe could not be fetched. {{}} $error}');
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
