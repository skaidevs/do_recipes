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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: Container(
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
              arguments: recipeData,
            );
          },
          child: Stack(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text(''), flex: 6),
                Expanded(
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(
                      16.0,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: recipeData.imageUrl,
                      height: 174.0,
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
                  flex: 8,
                ),
                Expanded(child: Text(''), flex: 0)
              ],
            ),
            _headerTodayTitle(),
            const SizedBox(
              height: 28.0,
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
                /*Container(
                  padding: EdgeInsets.all(
                    8.0,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(
                      8.0,
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
                        const SizedBox(
                          height: 14.0,
                        ),
                        _timeCal(),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
