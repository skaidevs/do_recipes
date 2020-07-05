import 'package:flutter/cupertino.dart';

class Recipe with ChangeNotifier {
  final String id;
  final String title;
  final String time;
  final String difficulty;
  final String calories;
  final String imageUri;
  final List ingredients;
  final List method;
  bool isFavorite;

  Recipe(
      {@required this.id,
      @required this.title,
      @required this.time,
      @required this.difficulty,
      @required this.calories,
      @required this.imageUri,
      @required this.ingredients,
      @required this.method,
      this.isFavorite = false});

  /*factory Recipe.fromJson(Map<String, dynamic> parsedJson) {
    return Recipe(
      id,
      title,
      time,
      difficulty,
      calories,
      imageUri,
      ingredients,
      method,
    );
  }*/
}
