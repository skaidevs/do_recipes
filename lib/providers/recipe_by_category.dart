import 'dart:convert';
import 'dart:io';

import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'all_recipe.dart';

class RecipeByCategoryNotifier with ChangeNotifier {
  Map<String, List<Data>> _cachedRecipeByCategory;

  List<Data> _recipeByCategoryList = [];

  List<Data> get recipeByCategoryList {
    return [..._recipeByCategoryList];
  }

  String _error = '';
  String get error => _error;
  String _internetMessage = '';
  String get internetMessage => _internetMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Data findAlbumById({String code}) {
    return _recipeByCategoryList.firstWhere((id) => id.id == code);
  }

  Future<void> loadRecipeByCategory({
    String categoryId,
  }) async {
    return await _initializeAndUpdateRecipeByCategory(categoryId: categoryId);
  }

  RecipeByCategoryNotifier() : _cachedRecipeByCategory = Map() {
    // _initializeAndUpdateRecipeByCategory();
  }

  Future<List<Data>> _initializeAndUpdateRecipeByCategory(
      {String categoryId}) async {
    _internetMessage = '';
    _error = '';
    _isLoading = true;
    notifyListeners();
    _recipeByCategoryList = await _getRecipeByCategory(categoryId: categoryId);

    return _recipeByCategoryList;
  }

  Future<List<Data>> _getRecipeByCategory({String categoryId}) async {
    if (!_cachedRecipeByCategory.containsKey(categoryId)) {
      try {
        final _recipeByCategoryResponse = await http
            .get(Uri.parse('$baseUrl' + 'recipes?category=$categoryId'));

        if (_recipeByCategoryResponse.statusCode == 200) {
          var extractedData = json.decode(_recipeByCategoryResponse.body);
          if (extractedData == null) {
            return null;
          }
          Recipe _recipe = Recipe.fromJson(extractedData);
          _cachedRecipeByCategory[categoryId] = _recipe.data;

          _isLoading = false;
          notifyListeners();
        } else {
          _error = _recipeByCategoryResponse.body.toString();
          _isLoading = false;
          notifyListeners();
          /*throw RecipeError(
              'Recipe could not be fetched. {{}} ${_recipeByCategoryResponse.body}');*/
        }
      } on SocketException catch (_) {
        _internetMessage = 'No internet';
        _isLoading = false;
        notifyListeners();
      } catch (e) {
        // _error = e;
        print("Error in catch fetched: $e");
      }
    }
    _isLoading = false;
    notifyListeners();
    return _cachedRecipeByCategory[categoryId];
  }
}
