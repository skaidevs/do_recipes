import 'package:cached_network_image/cached_network_image.dart';
import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/providers/offline_recipes.dart';
import 'package:dorecipes/screens/recipe_detail.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridItemCard extends StatelessWidget {
  final Data data;
  final String currentScreen;

  const GridItemCard({Key key, this.data, this.currentScreen})
      : super(key: key);

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

class RecipeBookmarkWidget extends StatefulWidget {
  final Data data;
  RecipeBookmarkWidget(this.data);

  @override
  _RecipeBookmarkWidgetState createState() => _RecipeBookmarkWidgetState();
}

class _RecipeBookmarkWidgetState extends State<RecipeBookmarkWidget> {
  Future<bool> get isBookmark async {
    final rowsPresent = await DBHelper.queryForFav(widget?.data?.id);
    if (rowsPresent > 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OfflineNotifier>(
      builder: (context, notifier, _) => FutureBuilder<bool>(
          future: isBookmark,
          initialData:
              false, // you can define an initial value while the db returns the real value
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return const Icon(Icons.error,
                  color: Colors.red); //just in case the db return an error
            return IconButton(
              onPressed: () =>
                  notifier.insertInToDataBase(widget?.data, context).then(
                        (_) => setState(() {}),
                      ),
              icon: Icon(
                Icons.bookmark_outlined,
                size: 22,
                color: !snapshot.data ? kColorTeal : kColorGrey,
              ),
            );
          }),
    );
  }
}

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

/*
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
*/
