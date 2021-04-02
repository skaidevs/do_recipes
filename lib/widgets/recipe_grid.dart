import 'package:cached_network_image/cached_network_image.dart';
import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/screens/recipe_detail.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/recipe_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeGrid extends StatelessWidget {
  final List<Data> data;

  const RecipeGrid({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final _data = data[index];
        return GridItemCard(
          data: _data,
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 3,
        mainAxisSpacing: 4,
      ),
      padding: const EdgeInsets.all(
        2.0,
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }
}

class SearchRecipeGrid extends StatelessWidget {
  final List<Data> recipeData;
  const SearchRecipeGrid({Key key, this.recipeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: recipeData?.length ?? 0,
      itemBuilder: (context, index) => RecipeGridItem(
        id: recipeData[index].id,
        title: recipeData[index].title,
        duration: recipeData[index].duration,
        imageUrl: recipeData[index].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3.4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      padding: const EdgeInsets.all(4.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }
}

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
            arguments: data.id,
          );
        },
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              child: CachedNetworkImage(
                imageUrl: addHttps(data.imageUrl),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: kColorTeal.withOpacity(
                    0.1,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ) /*Image.network(
                addHttps(data.imageUrl),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                scale: 1.0,
              )*/
              ,
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
                            /*TextSpan(
                              text: 'anything can be here',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),*/
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 22,
                                  color: kColorGrey,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 4.0,
                                      left: 2.0,
                                    ),
                                    child: Text(
                                      data.duration,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: kBalooTamma2,
                                        color: kColorGrey,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            onTap: () {
                              print('Saved Recipe');
                              DBHelper.insertRecipe(
                                data: data,
                              );
                            },
                            child: Icon(
                              Icons.bookmark_outlined,
                              size: 22,
                              color: kColorTeal,
                            ),
                          ),
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

String addHttps(String imageUri) {
  String _imageUri = imageUri;
  if (_imageUri.contains('http:')) {
    final String imageUriSubstring = _imageUri.substring(4);
    _imageUri = 'https$imageUriSubstring';
  }
  return _imageUri;
}
