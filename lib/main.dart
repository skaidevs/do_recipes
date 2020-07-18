import 'package:daisyinthekitchen/providers/bottom_navigator.dart';
import 'package:daisyinthekitchen/providers/recipes.dart';
import 'package:daisyinthekitchen/providers/shopping_list.dart';
import 'package:daisyinthekitchen/screens/admin.dart';
import 'package:daisyinthekitchen/screens/recipe_book.dart';
import 'package:daisyinthekitchen/screens/recipe_detail.dart';
import 'package:daisyinthekitchen/screens/recipe_overview.dart';
import 'package:daisyinthekitchen/screens/shopping_list.dart';
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
        ChangeNotifierProvider<RecipeNotifier>(
          create: (context) => RecipeNotifier(),
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
    _pages = [
      {
        'page': RecipeOverviewScreen(),
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

  @override
  Widget build(BuildContext context) {
    _bottomNavigation = Provider.of<BottomNavigation>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_bottomNavigation.currentIndex]['title']),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('Taped');
              })
        ],
      ),
      body: _pages[_bottomNavigation.currentIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildBottomNavBarItem(
              iconData: Icons.restaurant, title: 'Browse Recipe'),
          _buildBottomNavBarItem(
              iconData: Icons.shopping_cart, title: 'Shopping List'),
          _buildBottomNavBarItem(
              iconData: Icons.collections_bookmark, title: 'Recipe Book'),
          _buildBottomNavBarItem(iconData: Icons.add_box, title: 'Admin'),
        ],
        currentIndex: _bottomNavigation.currentIndex,
        onTap: (index) {
          _bottomNavigation.currentIndex = index;
        },
      ),
    );
  }
}
