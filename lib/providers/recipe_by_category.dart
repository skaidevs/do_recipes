import 'dart:collection';
import 'dart:convert';

import 'package:daisyinthekitchen/models/recipe.dart';
import 'package:daisyinthekitchen/providers/category.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RecipeByCategoryNotifier with ChangeNotifier {
  Map<String, List<Data>> _cachedRecipeByCategory;

  List<Data> _recipeDataByCategory = [];

  UnmodifiableListView<Data> get recipeDataByCategory =>
      UnmodifiableListView(_recipeDataByCategory);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Data findAlbumById({String code}) {
    return _recipeDataByCategory.firstWhere((id) => id.id == code);
  }

  Future<void> loadRecipeByCategory({
    String category,
  }) async {
    return await _initializeAndUpdateRecipeByCategory(category: category);
  }

  RecipeByCategoryNotifier() : _cachedRecipeByCategory = Map() {
    _initializeAndUpdateRecipeByCategory();
  }

  Future<List<Data>> _initializeAndUpdateRecipeByCategory(
      {String category}) async {
    _isLoading = true;
    notifyListeners();
    _recipeDataByCategory = await _getRecipeByCategory(category: category);
    return _recipeDataByCategory;
  }

  Future<List<Data>> _getRecipeByCategory({String category}) async {
    print('CATE!!!!! $category');
    if (category == null) {
      return null;
    }
    if (!_cachedRecipeByCategory.containsKey(category)) {
      final _recipeByCategoryResponse = await http.get(
        Uri.encodeFull('$baseUrl' + 'recipes?category=$category'),
      );
      print('Category Url $baseUrl' + 'recipes?category=$category');

      if (_recipeByCategoryResponse.statusCode == 200) {
        var extractedData = json.decode(_recipeByCategoryResponse.body);
        if (extractedData == null) {
          return null;
        }
        Recipe _recipe = Recipe.fromJson(extractedData);
        //print('Recipe Cate Data111 ${_recipe.data[0].category}');
        _cachedRecipeByCategory[category] = _recipe.data;

        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        print('ERROR ${_recipeByCategoryResponse.body.toString()}');
        throw RecipeError(
            'Recipe could not be fetched. {{}} ${_recipeByCategoryResponse.body}');
      }
    }
    _isLoading = false;
    notifyListeners();
    return _cachedRecipeByCategory[category];
  }
}