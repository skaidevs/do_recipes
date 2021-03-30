import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/screens/recipe_detail.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recipe_grid.dart';

class HeaderCard extends StatelessWidget {
  final Data recipeData;

  const HeaderCard({Key key, this.recipeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _headerTodayTitle() => Text(
          "Today's Menu",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        );
    Widget _title() => Text(
          recipeData.title,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
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
                    color: kColorGrey,
                  ),
                ),
                Text(
                  recipeData.duration,
                  style: TextStyle(
                    fontFamily: kBalooTamma2,
                    color: kColorGrey,
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
                    color: kColorGrey,
                  ),
                ),
                Text(
                  '${recipeData.calories} Cals',
                  style: TextStyle(
                    fontFamily: kBalooTamma2,
                    color: kColorGrey,
                    fontSize: 18.0,
                  ),
                ),
              ],
            )
          ],
        );
    return Stack(
      children: [
        /*ClipRRect(
          borderRadius: new BorderRadius.circular(40.0),
          child: Image.asset(
            'assets/images/pancake.jpeg',
            height: 80,
            width: 80,
          ),
        ),*/
        Consumer<RecipeDao>(
          builder: (context, notifier, _) => Container(
            // height: MediaQuery.of(context).size.height * 0.36,
            padding: EdgeInsets.all(
              20.0,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 1.0,
                  color: Colors.grey.shade400,
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
                  arguments: recipeData.id,
                );
              },
              child: Stack(children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text(''), flex: 9),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(
                          16.0,
                        ),
                        child: Image.network(
                          addHttps(recipeData.imageUrl),
                          //scale: 1.0,
                        ),
                      ),
                      flex: 8,
                    ),
                    Expanded(child: Text(''), flex: 0)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _headerTodayTitle(),
                    const SizedBox(
                      height: 28.0,
                    ),
                    _title(),
                    const SizedBox(
                      height: 14.0,
                    ),
                    _timeCal(),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
