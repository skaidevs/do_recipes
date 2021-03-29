import 'package:flutter/foundation.dart';

class Category with ChangeNotifier {
  final String id;
  final String name;
  final String addedAt;
  final int recipes;

  Category({this.id, this.name, this.addedAt, this.recipes});

  factory Category.fromJson(Map<String, dynamic> parsedJson) {
    return Category(
      id: parsedJson['_id'] as String,
      name: parsedJson['name'] as String,
      addedAt: parsedJson['addedAt'] as String,
      recipes: parsedJson['recipes'] as int,
    );
  }
}

class CategoryList with ChangeNotifier {
  final List<Category> category;
  CategoryList({this.category});

  factory CategoryList.fromJson(List<dynamic> parsedJson) {
    List<Category> category = [];
    category = parsedJson.map((i) => Category.fromJson(i)).toList();

    return new CategoryList(
      category: category,
    );
  }
}
