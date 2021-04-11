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
            physics: NeverScrollableScrollPhysics(),
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

  Widget _buildItem(Category category) {
    final notifier = Provider.of<RecipeByCategoryNotifier>(
      context,
      listen: false,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // stops: [0.9, 0.7, 0.5, 0.1],
          colors: [
            Colors.teal[100],
            Colors.teal[200],
            Colors.teal[400],
            Colors.teal[500],
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Map _data = {
            'id': category.id,
            'name': category.name,
          };
          _selectedCategory(data: _data);
        },
        child: Stack(
          children: <Widget>[
            /* ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              child: CachedNetworkImage(
                imageUrl: notifier?.recipeByCategoryList[0]?.imageUrl,
                // height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: kColorTeal.withOpacity(
                    0.1,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),*/
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
                  color: Colors.black.withOpacity(
                    0.7,
                  ),
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
