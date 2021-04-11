import 'dart:collection';
import 'dart:convert';

import 'package:dorecipes/models/list_categories.dart' as cati;
import 'package:dorecipes/models/list_categories.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CategoryNotifier with ChangeNotifier {
  Map<String, List<cati.Category>> _cachedCategories;
  String _categoryError = '';
  String _internetConnectionError = '';

  String get categoryError => _categoryError;
  bool _isCategoryLoaded = false;
  bool get isCategoryLoaded => _isCategoryLoaded;

  List<cati.Category> _categoryList = [];

  UnmodifiableListView<cati.Category> get categoryListData =>
      UnmodifiableListView(_categoryList);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CategoryNotifier() : _cachedCategories = Map() {
    initializeCategories().then((_) async {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<List<cati.Category>> initializeCategories() async {
    _internetConnectionError = '';
    _categoryError = '';
    _isLoading = true;
    notifyListeners();

    return _categoryList = await _updateCategories();
  }

  Future<void> refreshCategory() async {
    _internetConnectionError = '';
    _categoryError = '';
    _isLoading = true;
    notifyListeners();
    await _updateCategories().then((categoryList) {
      _categoryList = categoryList;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<List<cati.Category>> _updateCategories() async {
    final futureCategories = await _getCategories().catchError((onError) {
      print("SOMETHING IS WRONG In Category. $onError");
      if (onError.toString().contains('SocketException')) {
        _internetConnectionError = 'error';
      } else {
        _categoryError = 'error';
      }
      _isLoading = false;
      notifyListeners();
    });
    return futureCategories;
  }

  Future<List<cati.Category>> _getCategories() async {
    String recipes = 'recipes';
    if (!_cachedCategories.containsKey(recipes)) {
      final _categoryResponse = await http.get(
        Uri.parse('$baseUrl${'categories'}'),
      );
      if (_categoryResponse.statusCode == 200) {
        var extractedData = json.decode(_categoryResponse.body);
        if (extractedData == null) {
          return null;
        }
        CategoryList _category = CategoryList.fromJson(extractedData);
        _cachedCategories[recipes] = _category.category;
        _isCategoryLoaded = true;
      } else {
        _categoryError = _categoryResponse.body.toString();
        throw RecipeError('Categories could not be fetched. {{}}');
      }
    }
    return _cachedCategories[recipes];
  }
}

class RecipeError {
  final String message;
  RecipeError(this.message);
}
