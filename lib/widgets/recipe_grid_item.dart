import 'package:daisyinthekitchen/models/recipe.dart';
import 'package:daisyinthekitchen/screens/recipe_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeGridItem extends StatelessWidget {
  /*final String id;
  final String title;
  final String imageUrl;
  final String time;

  RecipeGridItem({
    this.id,
    this.title,
    this.imageUrl,
    this.time,
  });*/

  @override
  Widget build(BuildContext context) {
    final _recipe = Provider.of<Recipe>(context, listen: false);
    final _shoppingList = Provider.of<Recipe>(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          RecipeDetailScreen.routeName,
          arguments: _recipe.id,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          2.0,
        ),
        child: GridTile(
          child: Image.network(
            _recipe.imageUri,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            subtitle: Text(
              _recipe.title,
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black54,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    size: 13,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      _recipe.time,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
