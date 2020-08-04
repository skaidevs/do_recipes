import 'dart:collection';
import 'dart:convert';

import 'package:daisyinthekitchen/models/recipe.dart';
import 'package:daisyinthekitchen/providers/category.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://recipes.trapcode.io/app/';

class AllRecipeNotifier with ChangeNotifier {
  Map<String, List<Data>> _cachedAllRecipe;

  List<Data> _allRecipeData = [];

  UnmodifiableListView<Data> get allRecipeData =>
      UnmodifiableListView(_allRecipeData);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Data findAlbumById({String code}) {
    return _allRecipeData.firstWhere((id) => id.id == code);
  }

  AllRecipeNotifier() : _cachedAllRecipe = Map() {
    _initializeAllRecipe().then((_) async {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> _initializeAllRecipe() async {
    _allRecipeData = await _updateAllRecipe();
    print('Whats here ${_allRecipeData[0].title}');
  }

  Future<List<Data>> _updateAllRecipe() async {
    _isLoading = true;
    notifyListeners();
    final futureRecipe = await _getAllRecipe();
    print('Length ${futureRecipe.length}');
    return futureRecipe;
  }

  Future<List<Data>> _getAllRecipe() async {
    String _id = '_id';
    if (!_cachedAllRecipe.containsKey(_id)) {
      final _allRecipeResponse = await http.get(
        Uri.encodeFull('$baseUrl${'recipes'}'),
      );
      if (_allRecipeResponse.statusCode == 200) {
        var extractedData = json.decode(_allRecipeResponse.body);
        if (extractedData == null) {
          return null;
        }
        print('Recipe Data ${extractedData.toString()}');
        Recipe _recipe = Recipe.fromJson(extractedData);
        print(' Recipe Data1 ${_recipe.data[0].title}');

        _cachedAllRecipe[_id] = _recipe.data;
      } else {
        print('ERROR ${_allRecipeResponse.body.toString()}');
        throw RecipeError(
            'Recipe could not be fetched. {{}} ${_allRecipeResponse.body}');
      }
    }
    return _cachedAllRecipe[_id];
  }
}
