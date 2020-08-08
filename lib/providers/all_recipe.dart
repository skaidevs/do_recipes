import 'dart:collection';
import 'dart:convert';

import 'package:daisyinthekitchen/models/recipe.dart';
import 'package:daisyinthekitchen/providers/category.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://recipes.trapcode.io/app/';

class AllRecipeNotifier with ChangeNotifier {
  Map<String, List<Data>> _cachedAllRecipe;

  int _activeServe = 0;
  int get activeServe => _activeServe;
  List _serve;

  List<Data> _allRecipeData = [];
  String error = '';
  var _eachServes;
  dynamic get eachServes => _eachServes;

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
  }

  Future<List<Data>> _updateAllRecipe() async {
    _isLoading = true;
    notifyListeners();
    final futureRecipe = await _getAllRecipe().catchError((onError) {
      print("SOMETHING IS WRONG IN ALL RECIPE. $onError");
      _isLoading = false;
      notifyListeners();
      return;
    });
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

        Recipe _recipe = Recipe.fromJson(extractedData);
        _recipe.data.forEach((ingredient) {
          _serve = ingredient.ingredients;
        });

        _eachServes = _serve[_activeServe];
        //print('EachServes... $_eachServes');
        notifyListeners();
        _cachedAllRecipe[_id] = _recipe.data;
      } else {
        error = _allRecipeResponse.body.toString();
        print('ERROR in All Recipe $error');
        throw RecipeError('Recipe could not be fetched. {{}} $error}');
      }
    }
    return _cachedAllRecipe[_id];
  }

  void slideToPrev() {
    if (_activeServe > -_serve.length) {
      if (_activeServe <= 0) {
        return;
      }
      _activeServe--;
      _eachServes = _serve[_activeServe];
      notifyListeners();
    } else {
      return;
    }
  }

  void slideToNext() {
    //print('Called Button');
    if (_activeServe < _serve.length - 1) {
      _activeServe++;
      _eachServes = _serve[_activeServe];
      notifyListeners();
    } else {
      return;
    }
  }
}
