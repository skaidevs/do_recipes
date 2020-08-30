import 'package:daisyinthekitchen/helpers/ingredient_database.dart';
import 'package:daisyinthekitchen/helpers/recipe_database.dart';
import 'package:daisyinthekitchen/providers/all_recipe.dart';
import 'package:daisyinthekitchen/providers/bottom_navigator.dart';
import 'package:daisyinthekitchen/screens/all_recipe_and_catigories.dart';
import 'package:daisyinthekitchen/screens/recipe_book.dart';
import 'package:daisyinthekitchen/screens/shopping_list.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:daisyinthekitchen/widgets/loading_info.dart';
import 'package:daisyinthekitchen/widgets/search.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
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
  bool _isLoading = false;

  bool _isConnectionReady = false;

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
    _fetchDataAndCheckConnection();
    super.initState();
  }

  Future _fetchDataAndCheckConnection() {
    setState(() {
      _isLoading = true;
    });
    return Future.delayed(
      Duration(seconds: 3),
    ).then((_) async {
      final _notifier = Provider.of<AllRecipeNotifier>(
        context,
        listen: false,
      );
      await Provider.of<AllRecipeNotifier>(context, listen: false)
          .initializeAllRecipe()
          .then((_) {
        return _checkConnection().then((value) {
          //print('connection???????? $_isLoading');
          _isConnectionReady = value;

          if (_isConnectionReady == true) {
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

            setState(() {
              _isLoading = false;
              _notifier.isLoading = false;
            });
          } else {
            _pages = [
              {
                'page': Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'No Internet Connection!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontFamily: kBalooTamma2,
                            color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: Theme.of(context).primaryColor,
                              size: 40,
                            ),
                            onPressed: () {
                              _fetchDataAndCheckConnection();
                            }),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          _bottomNavigation.currentIndex = 2;
                          /*...*/
                        },
                        child: Text(
                          "Go to recipe book",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
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
            setState(() {
              _isLoading = false;
            });
          }
        });
      });
    });
  }

  Future<bool> _checkConnection() async {
    bool _result = await DataConnectionChecker().hasConnection;

    return _result;
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
            FlatButton(
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
            FlatButton(
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
            FlatButton(
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
            FlatButton(
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
      appBar: _isLoading
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
                      final downloadRecipes = snapshot.data ?? List();
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
            ),
      body: _isLoading
          ? Center(
              child: Container(
                child: LoadingInfo(),
              ),
            )
          : _pages[_bottomNavigation.currentIndex]['page'],
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
