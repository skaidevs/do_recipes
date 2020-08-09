import 'package:daisyinthekitchen/providers/all_recipe.dart';
import 'package:daisyinthekitchen/screens/recipe_detail.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeGridItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String duration;

  RecipeGridItem({
    this.id,
    this.title,
    this.imageUrl,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AllRecipeNotifier>(
          context,
          listen: false,
        ).activeServe = 0;
        Navigator.of(context)
            .pushNamed(RecipeDetailScreen.routeName, arguments: id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          2.0,
        ),
        child: GridTile(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            subtitle: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: kBalooTamma2,
                color: Colors.white,
              ),
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
                      duration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: kBalooTamma2,
                        fontSize: 12,
                      ),
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
