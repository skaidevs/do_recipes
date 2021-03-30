import 'package:dorecipes/models/list_categories.dart';
import 'package:dorecipes/providers/category.dart';
import 'package:dorecipes/providers/recipe_by_category.dart';
import 'package:dorecipes/screens/recipes_by_category.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  static const routeName = '/all_categories';

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Card _buildCategoryContainer({String title, String recipeNum}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 20.0,
          bottom: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: kColorDKGreen,
                fontFamily: kBalooTamma2,
              ),
              //textAlign: TextAlign.start,
            ),
            Container(
              //width: 30,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    recipeNum,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kColorWhite,
                      fontFamily: kBalooTamma2,
                      //fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: kColorDKGreen,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Viewing All Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: Consumer<CategoryNotifier>(
        builder: (context, notifier, _) => Container(
          alignment: Alignment.center,
          child: GridView(
            padding: const EdgeInsets.all(
              10.0,
            ),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 2.6,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            children: notifier.categoryListData.map(_buildItem).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(Category category) => Container(
        child: GestureDetector(
          onTap: () {
            Map _data = {
              'id': category.id,
              'name': category.name,
            };
            _selectedCategory(data: _data);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Image.asset(
                    'assets/images/pancake.jpeg',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  //top: 10.0,
                  bottom: 10.0,
                  right: 10.0,
                  left: 0.0,
                  child: Container(
                    padding: EdgeInsets.all(
                      6.0,
                    ),
                    decoration: BoxDecoration(
                      color: kColorTeal,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(2.0),
                        topRight: Radius.circular(50.0),
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
                            //alignment: Alignment.bottomLeft,
                            child: Text(
                              category.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: kColorWhite,
                              ),
                            ),
                          ),
                          /*RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: '',

                              ),
                            ]),
                          )*/
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

  void _selectedCategory({
    Map data,
  }) {
    final _notifier = Provider.of<RecipeByCategoryNotifier>(
      context,
      listen: false,
    );
    _notifier.loadRecipeByCategory(categoryId: data['id']);
    Navigator.of(context).pushNamed(
      RecipesByCategory.routeName,
      arguments: data,
    );
  }
}
