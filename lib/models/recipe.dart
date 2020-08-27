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

/*
{
"_id": "5f28bbdc77b7a41e60207d50",
"publishedAt": "2020-08-04T01:38:07.484Z",
"title": "Tea",
"image": "/recipes/SRSyv5vWJjHMn0uLE503.jpg",
"category": "Breakfast",
"calories": "2",
"duration": "5 minutes",
"difficulty": "easy",
"method": "<ul>\n<li>Pour hot water in cup</li>\n<li>Add Coffee</li>\n<li>Add brown sugar</li>\n<li>Add Milk</li>\n<li>Stir it for a while</li>\n<li>Sit down</li>\n<li>Put on the tv</li>\n<li>Enjoy with better Agege bread</li>\n</ul>",
"status": "published",
"ingredients": [
[
"1 Hot Water",
"2 Nescafe Coffee",
"3 cube Brown Sugar",
"4 Milk (optional)",
"Agege Bread"
]
],
"imageUrl": "http://recipes.trapcode.io/storage/recipes/SRSyv5vWJjHMn0uLE503.jpg"
}
*/

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
  });

  factory Data.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Data(
        id: parsedJson['_id'] as String,
        publishedAt: parsedJson['publishedAt'] as String,
        title: parsedJson['title'] as String,
        image: parsedJson['image'] as String,
        category: parsedJson['category'] as String,
        calories: parsedJson['calories'] as String,
        duration: parsedJson['duration'] as String,
        difficulty: parsedJson['difficulty'] as String,
        imageUrl: parsedJson['imageUrl'] as String,
        method: parsedJson['method'] as String,
        preparation: parsedJson['preparation'] as String,
        ingredients: parsedJson['ingredients'] as List);
  }
}

// class RecipeIngredients with ChangeNotifier {
//   final String title;
//   final List ingredient;
//   RecipeIngredients({
//     this.title,
//     this.ingredient,
//   });
//
//   factory RecipeIngredients.fromJson(Map<String, dynamic> parsedJson) {
//     var list = parsedJson['ingredient'] as List;
//     List<Data> recipeData = list.map((i) => Data.fromJson(i)).toList();
//     return RecipeIngredients(
//       data: recipeData,
//     );
//   }
// }
