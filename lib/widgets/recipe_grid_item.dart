import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/screens/download_details.dart';
import 'package:dorecipes/screens/recipe_detail.dart';
import 'package:dorecipes/widgets/commons.dart';
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
    return InkWell(
      onTap: () {
        //print('Clicked Downloaded Details ${}');

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
          child: FadeInImage.memoryNetwork(
            image: imageUrl,
            fit: BoxFit.cover,
          )
          /*Image.network(
            imageUrl,
            fit: BoxFit.cover,
          )*/
          ,
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

class DownloadedRecipeGridItem extends StatelessWidget {
  final DownloadRecipe downloadRecipe;

  DownloadedRecipeGridItem({
    this.downloadRecipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Clicked Downloaded Details ${downloadRecipe.title}');
        Provider.of<AllRecipeNotifier>(
          context,
          listen: false,
        ).activeServe = 0;

        Navigator.of(context).pushNamed(DownloadedRecipeDetailScreen.routeName,
            arguments: downloadRecipe);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          2.0,
        ),
        child: GridTile(
          child: Image.network(
            downloadRecipe.imageUri,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            subtitle: Text(
              downloadRecipe.title,
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
                      downloadRecipe.duration,
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
