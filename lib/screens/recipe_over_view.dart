import 'package:daisyinthekitchen/helpers/recipe_database.dart';
import 'package:daisyinthekitchen/providers/bottom_navigator.dart';
import 'package:daisyinthekitchen/screens/admin.dart';
import 'package:daisyinthekitchen/screens/all_recipe_and_catigories.dart';
import 'package:daisyinthekitchen/screens/recipe_book.dart';
import 'package:daisyinthekitchen/screens/shopping_list.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:daisyinthekitchen/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoRecipeHomePage extends StatefulWidget {
  DoRecipeHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DoRecipeHomePageState createState() => _DoRecipeHomePageState();
}

class _DoRecipeHomePageState extends State<DoRecipeHomePage> {
  List<Map<String, Object>> _pages;
  var _bottomNavigation;

  BottomNavigationBarItem _buildBottomNavBarItem({
    IconData iconData,
    String title,
  }) {
    return BottomNavigationBarItem(
      backgroundColor: Theme.of(context).accentColor,
      icon: Icon(iconData),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: kBalooTamma2,
        ),
      ),
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
    _pages = [
      {
        'page': AllRecipeAndCategories(),
        'title': 'Daisy In The Kitchen',
      },
      {
        'page': ShoppingList(),
        'title': 'Shopping List',
      },
      {
        'page': RecipeBook(),
        'title': 'Recipe Book',
      },
      {
        'page': Admin(),
        'title': 'Admin',
      },
    ];
    super.initState();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final dao = Provider.of<RecipeDao>(
          context,
          listen: false,
        );
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Clear",
            style: TextStyle(fontFamily: kBalooTamma2),
          ),
          content: new Text(
            "Are you sure you want to clear all Recipe Book?",
            style: TextStyle(
              fontFamily: kBalooTamma2,
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(fontSize: 18.0, fontFamily: kBalooTamma2),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text(
                "Clear",
                style: TextStyle(fontSize: 18.0, fontFamily: kBalooTamma2),
              ),
              onPressed: () {
                dao.deleteAllDownloadRecipe().then((_) {
                  Navigator.of(context).pop();
                  kFlutterToast(context: context, msg: 'Recipe Book Cleared');
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavigation = Provider.of<BottomNavigation>(
      context,
    );

    final dao = Provider.of<RecipeDao>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          _pages[_bottomNavigation.currentIndex]['title'],
          style: TextStyle(fontFamily: kBalooTamma2),
        ),
        actions: <Widget>[
          StreamBuilder(
              stream: dao.watchDownloadRecipes(),
              builder: (context, AsyncSnapshot<List<DownloadRecipe>> snapshot) {
                final downloadRecipes = snapshot.data ?? List();
                if (snapshot.data == null) {
                  return Container();
                } else if (downloadRecipes.isEmpty) {
                  return Container();
                } else {
                  return _bottomNavigation.currentIndex == 2
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDialog();
                          })
                      : Container();
                }
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: RecipeSearch(),
                );
              }),
        ],
      ),
      body: _pages[_bottomNavigation.currentIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
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
          /* _buildBottomNavBarItem(
            iconData: Icons.add_box,
            title: 'Admin',
          ),*/
        ],
        currentIndex: _bottomNavigation.currentIndex,
        onTap: (index) {
          _bottomNavigation.currentIndex = index;
        },
      ),
    );
  }
}
