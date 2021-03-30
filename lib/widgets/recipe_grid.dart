import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/recipe_grid_item.dart';
import 'package:flutter/material.dart';

class RecipeGrid extends StatelessWidget {
  final List<Data> data;

  const RecipeGrid({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 8 /*data.length*/,
      itemBuilder: (context, index) => GridItemCard(),
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
  @override
  Widget build(BuildContext context) {
    //final product = Provider.of<Product>(context, listen: false);
    return Container(
      /* height: 120.0,
      width: 100.0,*/
      child: GestureDetector(
        onTap: () {
          /*Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id);*/
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                child: Image.asset(
                  'assets/images/pancake.jpeg',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10.0,
                right: 8.0,
                left: 8.0,
                child: Container(
                  padding: EdgeInsets.all(
                    6.0,
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
                          alignment: Alignment.bottomLeft,
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Anything can be here \n',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 6.0,
                                    ),
                                    child: Icon(
                                      Icons.access_time,
                                      size: 20,
                                      color: kColorGrey,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'minutes',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: kBalooTamma2,
                                        color: kColorGrey,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Icon(
                                Icons.bookmark_outline_outlined,
                                size: 22,
                                color: kColorGrey,
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
      ),
    );
  }
}
