import 'package:cached_network_image/cached_network_image.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/screens/recipe_detail.dart';
import 'package:dorecipes/widgets/addAndRemoveRecipe.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridItemCard extends StatelessWidget {
  final Data data;

  const GridItemCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        onTap: () {
          Provider.of<AllRecipeNotifier>(
            context,
            listen: false,
          ).activeServe = 0;
          Navigator.of(context).pushNamed(
            RecipeDetailScreen.routeName,
            arguments: data,
          );
        },
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              child: CachedNetworkImage(
                imageUrl: data.imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: kColorTeal.withOpacity(
                    0.1,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 8.0,
              left: 8.0,
              child: Container(
                padding: EdgeInsets.all(
                  8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1.0,
                      color: Colors.black38,
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
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: data.title,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /*Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                size: 22,
                                color: kColorGrey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 4.0,
                                  left: 2.0,
                                ),
                                child: Text(
                                  data.duration,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontFamily: kBalooTamma2,
                                    color: kColorGrey,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),*/
                          Expanded(
                            child: Text(
                              data.duration,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontFamily: kBalooTamma2,
                                color: kColorGrey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          RecipeBookmarkWidget(data),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
