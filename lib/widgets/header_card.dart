import 'package:cached_network_image/cached_network_image.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/screens/recipe_detail.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderCard extends StatelessWidget {
  final Data recipeData;

  const HeaderCard({Key key, this.recipeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _headerTodayTitle() => Text(
          "Today's Menu",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: kColorWhite,
          ),
        );
    Widget _title() => Text(
          recipeData.title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: kColorWhite,
          ),
        );

    Widget _timeCal() => Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 6.0,
                  ),
                  child: Icon(
                    Icons.access_time,
                    size: 22,
                    color: kColorWhite,
                  ),
                ),
                Text(
                  recipeData.duration,
                  style: TextStyle(
                    color: kColorWhite,
                    //fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 14.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(
                    Icons.show_chart,
                    size: 22,
                    color: kColorWhite,
                  ),
                ),
                Text(
                  '${recipeData.calories} Cals',
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: kColorWhite,
                    fontSize: 18.0,
                  ),
                ),
              ],
            )
          ],
        );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 0.0,
              color: kColorGrey,
            ),
          ],
          /*gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  // stops: [0.9, 0.7, 0.5, 0.1],
                  colors: [
                    Colors.teal[100],
                    Colors.teal[100],
                    Colors.teal[200],
                    Colors.teal[200],
                  ],
                ),*/
          /* color: Theme.of(context).accentColor,*/
          color: kColorWhite,
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Provider.of<AllRecipeNotifier>(
              context,
              listen: false,
            ).activeServe = 0;
            Navigator.of(context).pushNamed(
              RecipeDetailScreen.routeName,
              arguments: recipeData,
            );
          },
          child: Stack(children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(
                16.0,
              ),
              child: CachedNetworkImage(
                imageUrl: recipeData.imageUrl,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: kColorTeal.withOpacity(
                    0.1,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ) /*Image.network(
                      addHttps(recipeData.imageUrl),
                      //scale: 1.0,
                    )*/
              ,
            ),
            Padding(
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: _headerTodayTitle(),
            ),
            Positioned(
              //top: 10.0,
              bottom: 16.0,
              right: 16.0,
              left: 0.0,
              child: Container(
                padding: EdgeInsets.all(
                  6.0,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.7,
                      ),
                    ),
                  ],
                  // color: kColorTeal.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(
                      2.0,
                    ),
                    topRight: Radius.circular(
                      50.0,
                    ),
                  ),
                ),
                //width: 320.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title(),
                      _timeCal(),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
