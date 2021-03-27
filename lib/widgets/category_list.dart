import 'package:dorecipes/providers/category.dart';
import 'package:dorecipes/providers/recipe_by_category.dart';
import 'package:dorecipes/screens/all_recipe.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  final CategoryNotifier notifier;
  const CategoryList({Key key, this.notifier}) : super(key: key);

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
    return ListView.builder(
      itemCount: notifier.categoryListData.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          var _data = {
            'id': notifier.categoryListData[index].id,
            'name': notifier.categoryListData[index].name
          };
          //print('Category ${notifier.categoryListData[index].name}');
          _selectedCategory(
            data: _data,
            context: context,
          );
        },
        child: _buildCategoryContainer(
          title: notifier.categoryListData[index].name,
          recipeNum: notifier.categoryListData[index].recipes.toString(),
        ),
      ),
      padding: const EdgeInsets.all(4.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }

  void _selectedCategory({
    BuildContext context,
    dynamic data,
  }) {
    final _notifier = Provider.of<RecipeByCategoryNotifier>(
      context,
      listen: false,
    );
    _notifier.loadRecipeByCategory(category: data);
    Navigator.of(context).pushNamed(
      AllRecipeByCategory.routeName,
      arguments: data,
    );
  }
}
