import 'package:dorecipes/providers/offline_recipes.dart';
import 'package:dorecipes/screens/categories.dart';
import 'package:dorecipes/screens/recipe_book.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/all_recipe.dart';
import 'providers/bottom_navigator.dart';
import 'providers/category.dart';
import 'providers/recipe_by_category.dart';
import 'providers/shopping_list.dart';
import 'screens/do_recipe_home.dart';
import 'screens/recipe_detail.dart';
import 'screens/recipes_by_category.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigation>(
          create: (_) => BottomNavigation(),
          child: DoRecipeHomePage(),
        ),
        ChangeNotifierProvider<BottomNavigation>(
          create: (_) => BottomNavigation(),
        ),
        /*Provider<RecipeDao>(
          create: (_) => AppDatabase().recipeDao,
          child: DoRecipeHomePage(),
          dispose: (context, db) => db.db.close(),
        ),
        Provider<RecipeIngredientDao>(
          create: (_) => AppDatabaseIngredient().recipeIngredientDao,
          child: DoRecipeHomePage(),
          dispose: (context, db) => db.db.close(),
        ),*/
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
        ChangeNotifierProvider<OfflineNotifier>(
          create: (_) => OfflineNotifier(),
          child: RecipeBook(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DO Recipes',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: kBalooTamma2,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.teal,
            ),
          ),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android:
                  CupertinoPageTransitionsBuilder() /*CustomPageTransitionBuilder()*/,
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        home: DoRecipeHomePage(),
        routes: {
          RecipeDetailScreen.routeName: (context) => RecipeDetailScreen(),
          RecipesByCategory.routeName: (context) => RecipesByCategory(),
          Categories.routeName: (context) => Categories(),
        },
      ),
    );
  }
}
