import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Recipe with ChangeNotifier {
  final int total;
  final int perPage;
  final int page;
  final int lastPage;
  final List<Data> data;

  Recipe({
    this.total,
    this.perPage,
    this.page,
    this.lastPage,
    this.data,
  });

  factory Recipe.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<Data> recipeData = list.map((i) => Data.fromJson(i)).toList();
    return Recipe(
      total: parsedJson['total'],
      lastPage: parsedJson['perPage'],
      page: parsedJson['page'],
      perPage: parsedJson['lastPage'],
      data: recipeData,
    );
  }
}

class Data with ChangeNotifier {
  final String id;
  final String publishedAt;
  final String title;
  final String image;
  final String category;
  final String calories;
  final String duration;
  final String difficulty;
  final String imageUrl;
  final String method;
  final String preparation;
  final List ingredients;
  //final bool isIngredientSaved;

  Data({
    this.id,
    this.publishedAt,
    this.title,
    this.image,
    this.category,
    this.calories,
    this.duration,
    this.difficulty,
    this.imageUrl,
    this.method,
    this.preparation,
    this.ingredients,
    //this.isIngredientSaved = false,
  });

  factory Data.fromJson(Map<dynamic, dynamic> parsedJson) {
    String addHttps(String imageUri) {
      String _imageUri = imageUri;
      if (_imageUri.contains('http:')) {
        final String imageUriSubstring = _imageUri.substring(4);
        _imageUri = 'https$imageUriSubstring';
      }
      return _imageUri;
    }

    return Data(
      id: parsedJson['_id'] as String,
      publishedAt: parsedJson['publishedAt'] as String,
      title: parsedJson['title'] as String,
      image: parsedJson['image'] as String,
      category: parsedJson['category'] as String,
      calories: parsedJson['calories'] as String,
      duration: parsedJson['duration'] as String,
      difficulty: parsedJson['difficulty'] as String,
      imageUrl: addHttps(parsedJson['imageUrl']),
      method: parsedJson['method'] as String,
      preparation: parsedJson['preparation'] as String,
      ingredients: parsedJson['ingredients'] as List,
    );
  }
  Data.fromDb(Map<String, dynamic> parsedDb)
      : id = parsedDb['_id'],
        publishedAt = parsedDb['publishedAt'],
        title = parsedDb['title'],
        image = parsedDb['image'],
        category = parsedDb['category'],
        calories = parsedDb['calories'],
        duration = parsedDb['duration'],
        difficulty = parsedDb['difficulty'],
        imageUrl = parsedDb['imageUrl'],
        method = parsedDb['method'],
        preparation = parsedDb['preparation'],
        ingredients = jsonDecode(parsedDb[
            'ingredients']) /*,
        isIngredientSaved = parsedDb['isIngredientSaved']*/
  ;

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      '_id': id,
      'publishedAt': publishedAt,
      'title': title,
      'image': image,
      'category': category,
      'calories': calories,
      'difficulty': difficulty,
      'duration': duration,
      'imageUrl': imageUrl,
      'method': method,
      'preparation': preparation,
      'ingredients': jsonEncode(ingredients),
    };
  }

  Map<String, dynamic> toMapForDbIng() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'duration': duration,
      'ingredients': jsonEncode(ingredients),
    };
  }
}
