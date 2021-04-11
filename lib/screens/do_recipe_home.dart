import 'package:dorecipes/providers/bottom_navigator.dart';
import 'package:dorecipes/screens/recipe_book.dart';
import 'package:dorecipes/screens/recipes_and_categories.dart';
import 'package:dorecipes/screens/shopping_list.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DoRecipeHomePage extends StatefulWidget {
  DoRecipeHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DoRecipeHomePageState createState() => _DoRecipeHomePageState();
}

class _DoRecipeHomePageState extends State<DoRecipeHomePage> {
  List<Map<String, Object>> _pages;
  var _bottomNavigation;

  SalomonBottomBarItem _buildBottomNavBarItem({
    IconData iconData,
    String title,
  }) {
    return SalomonBottomBarItem(
      icon: Icon(iconData),
      title: Text(title),
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    print('IS INIT');

    _initPages();
    super.initState();
  }

  Future<void> _initPages() async {
    _pages = [
      {
        'page': RecipesAndCategories(),
        'title': 'DO Recipes',
      },
      {
        'page': ShoppingList(),
        'title': 'Shopping List',
      },
      {
        'page': RecipeBook(),
        'title': 'Recipe Book',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavigation = Provider.of<BottomNavigation>(
      context,
    );
    return Scaffold(
      body: _pages[_bottomNavigation.currentIndex]['page'],
      bottomNavigationBar: Container(
        color: kColorWhite,
        child: SalomonBottomBar(
          margin: EdgeInsets.all(
            10.0,
          ),
          unselectedItemColor: kColorGrey,
          items: [
            _buildBottomNavBarItem(
              iconData: Icons.restaurant,
              title: 'Browse Recipe',
            ),
            _buildBottomNavBarItem(
              iconData: Icons.shopping_cart,
              title: 'Shopping List',
            ),
            _buildBottomNavBarItem(
              iconData: Icons.collections_bookmark,
              title: 'Recipe Book',
            ),
          ],
          currentIndex: _bottomNavigation.currentIndex,
          onTap: (index) {
            _bottomNavigation.currentIndex = index;
          },
        ),
      ),
    );
  }
}
