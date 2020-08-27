import 'package:daisyinthekitchen/helpers/recipe_database.dart';
import 'package:daisyinthekitchen/providers/all_recipe.dart';
import 'package:daisyinthekitchen/providers/bottom_navigator.dart';
import 'package:daisyinthekitchen/providers/category.dart';
import 'package:daisyinthekitchen/providers/recipe_by_category.dart';
import 'package:daisyinthekitchen/providers/shopping_list.dart';
import 'package:daisyinthekitchen/screens/admin.dart';
import 'package:daisyinthekitchen/screens/all_recipe.dart';
import 'package:daisyinthekitchen/screens/all_recipe_and_catigories.dart';
import 'package:daisyinthekitchen/screens/amin_edit_recipe.dart';
import 'package:daisyinthekitchen/screens/downlaod_details.dart';
import 'package:daisyinthekitchen/screens/recipe_book.dart';
import 'package:daisyinthekitchen/screens/recipe_detail.dart';
import 'package:daisyinthekitchen/screens/shopping_list.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:daisyinthekitchen/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigation>(
          create: (_) => BottomNavigation(),
          child: DaisyInTheKitchenHomePage(),
        ),
        Provider<RecipeDao>(
          create: (_) => AppDatabase().recipeDao,
          child: DaisyInTheKitchenHomePage(),
          dispose: (context, db) => db.db.close(),
        ),
        ChangeNotifierProvider<AllRecipeNotifier>(
          create: (context) => AllRecipeNotifier(),
        ),
        ChangeNotifierProvider<RecipeByCategoryNotifier>(
          create: (context) => RecipeByCategoryNotifier(),
        ),
        ChangeNotifierProvider<CategoryNotifier>(
          create: (context) => CategoryNotifier(),
        ),
        ChangeNotifierProvider<ShoppingListNotifier>(
          create: (context) => ShoppingListNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DINK',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: DaisyInTheKitchenHomePage(
          title: 'Daisy In The Kitchen',
        ),
        routes: {
          RecipeDetailScreen.routeName: (context) => RecipeDetailScreen(),
          DownloadedRecipeDetailScreen.routeName: (context) =>
              DownloadedRecipeDetailScreen(),
          AllRecipeByCategory.routeName: (context) => AllRecipeByCategory(),
          EditRecipe.routeName: (context) => EditRecipe(),
        },
      ),
    );
  }
}

class DaisyInTheKitchenHomePage extends StatefulWidget {
  DaisyInTheKitchenHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DaisyInTheKitchenHomePageState createState() =>
      _DaisyInTheKitchenHomePageState();
}

class _DaisyInTheKitchenHomePageState extends State<DaisyInTheKitchenHomePage> {
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

    final _allRecipeNotifier = Provider.of<AllRecipeNotifier>(
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
                print('Taped');
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
