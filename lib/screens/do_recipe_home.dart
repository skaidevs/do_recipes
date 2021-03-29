import 'package:dorecipes/helpers/ingredient_database.dart';
import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/providers/bottom_navigator.dart';
import 'package:dorecipes/screens/all_recipe_and_categories.dart';
import 'package:dorecipes/screens/recipe_book.dart';
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
  //bool _isLoading = false;
  bool _isConnectionReady = false;

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
    _initPages();
    super.initState();
  }

  Future<void> _initPages() async {
    _pages = [
      {
        'page': AllRecipeAndCategories(),
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
          title: const Text(
            "Clear recipe book",
            style: TextStyle(fontFamily: kBalooTamma2),
          ),
          content: const Text(
            "Are you sure you want to clear all items from recipe book?",
            style: TextStyle(
              fontFamily: kBalooTamma2,
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text(
                "CANCEL",
                style: TextStyle(
                  fontFamily: kBalooTamma2,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "CLEAR",
                style: TextStyle(
                  fontFamily: kBalooTamma2,
                ),
              ),
              onPressed: () {
                dao.deleteAllDownloadRecipe().then((_) {
                  Navigator.of(context).pop();
                  kFlutterToast(context: context, msg: 'Recipe book cleared');
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showIngDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final dao = Provider.of<RecipeIngredientDao>(
          context,
          listen: false,
        );
        // return object of type Dialog
        return AlertDialog(
          title: const Text(
            "Clear shopping list",
            style: TextStyle(fontFamily: kBalooTamma2),
          ),
          content: const Text(
            "Are you sure you want to clear all items from shopping list?",
            style: TextStyle(
              fontFamily: kBalooTamma2,
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text(
                "CANCEL",
                style: TextStyle(
                  fontFamily: kBalooTamma2,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "CLEAR",
                style: TextStyle(
                  fontFamily: kBalooTamma2,
                ),
              ),
              onPressed: () {
                dao.deleteAllDownloadIng().then((_) {
                  Navigator.of(context).pop();
                  kFlutterToast(context: context, msg: 'Shopping list cleared');
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
    final daoIng = Provider.of<RecipeIngredientDao>(
      context,
      listen: false,
    );

    return Scaffold(
      /*appBar: _isLoading
          ? null
          : AppBar(
              elevation: 0.0,
              title: Text(
                _pages[_bottomNavigation.currentIndex]['title'],
                style: TextStyle(fontFamily: kBalooTamma2),
              ),
              actions: <Widget>[
                StreamBuilder(
                    stream: daoIng.watchDownloadRecipes(),
                    builder: (context,
                        AsyncSnapshot<List<DownloadRecipeIngredientData>>
                            snapshot) {
                      final downloadRecipes = snapshot.data ?? [];
                      if (snapshot.data == null) {
                        return Container();
                      } else if (downloadRecipes.isEmpty) {
                        return Container();
                      } else {
                        return _bottomNavigation.currentIndex == 1
                            ? IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _showIngDialog();
                                })
                            : Container();
                      }
                    }),
                StreamBuilder(
                    stream: dao.watchDownloadRecipes(),
                    builder: (context,
                        AsyncSnapshot<List<DownloadRecipe>> snapshot) {
                      final downloadRecipes = snapshot.data ?? [];
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
                _isConnectionReady == true
                    ? IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: RecipeSearch(),
                          );
                        })
                    : Container(),
              ],
            ),*/
      body: _pages[_bottomNavigation.currentIndex]['page'],
      bottomNavigationBar: Container(
        color: kColorWhite,
        child: SalomonBottomBar(
          margin: EdgeInsets.all(
            10.0,
          ),
          unselectedItemColor: kColorGrey,

          //backgroundColor: Colors.white,
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
