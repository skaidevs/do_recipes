import 'package:daisyinthekitchen/helpers/ingredient_database.dart';
import 'package:daisyinthekitchen/helpers/recipe_database.dart';
import 'package:daisyinthekitchen/providers/all_recipe.dart';
import 'package:daisyinthekitchen/providers/bottom_navigator.dart';
import 'package:daisyinthekitchen/providers/category.dart';
import 'package:daisyinthekitchen/providers/recipe_by_category.dart';
import 'package:daisyinthekitchen/providers/shopping_list.dart';
import 'package:daisyinthekitchen/screens/all_recipe.dart';
import 'package:daisyinthekitchen/screens/amin_edit_recipe.dart';
import 'package:daisyinthekitchen/screens/downlaod_details.dart';
import 'package:daisyinthekitchen/screens/recipe_detail.dart';
import 'package:daisyinthekitchen/screens/recipe_over_view.dart';
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
          child: DoRecipeHomePage(),
        ),
        Provider<RecipeDao>(
          create: (_) => AppDatabase().recipeDao,
          child: DoRecipeHomePage(),
          dispose: (context, db) => db.db.close(),
        ),
        Provider<RecipeIngredientDao>(
          create: (_) => AppDatabaseIngredient().recipeIngredientDao,
          child: DoRecipeHomePage(),
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
        title: 'DO Recipes',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: DoRecipeHomePage(
          title: 'DO Recipes',
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
