import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/ingredient_database.dart';
import 'helpers/recipe_database.dart';
import 'providers/all_recipe.dart';
import 'providers/bottom_navigator.dart';
import 'providers/category.dart';
import 'providers/recipe_by_category.dart';
import 'providers/shopping_list.dart';
import 'screens/all_recipe.dart';
import 'screens/amin_edit_recipe.dart';
import 'screens/download_details.dart';
import 'screens/recipe_detail.dart';
import 'screens/recipe_over_view.dart';

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
