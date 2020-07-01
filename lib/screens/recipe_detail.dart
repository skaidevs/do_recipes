import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe_detail';
  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('hI'),
      ),
    );
  }
}
