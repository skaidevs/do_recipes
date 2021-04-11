import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/providers/offline_recipes.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/empty_and_error_recipe.dart';
import 'package:dorecipes/widgets/recipe_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeSearch extends SearchDelegate<Data> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  String get searchFieldLabel => 'Search Recipe';

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(
          context,
          null,
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer2<AllRecipeNotifier, OfflineNotifier>(
      builder: (context, notifier, offNotifier, _) {
        List<Data> result = [];
        if (notifier.internetConnectionError == '' &&
            notifier.recipeError == '') {
          result = notifier.allRecipeData
              .where(
                (recipe) => recipe?.title?.toLowerCase()?.contains(query),
              )
              .toList();
        } else {
          result = offNotifier.recipeList
              .where(
                (recipe) => recipe?.title?.toLowerCase()?.contains(query),
              )
              .toList();
        }

        if (result.isEmpty) {
          return Empty(
            text: '',
            screen: 'search',
          );
        }

        return RecipeGrid(
          recipeList: result,
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      //primaryColor: kColorDKGreen,
      //accentColor: kColorDKGreen,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: kColorTeal,
          fontSize: 20.0,
        ),
      ),
      primaryIconTheme: theme.primaryIconTheme.copyWith(
        color: Colors.teal,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer2<AllRecipeNotifier, OfflineNotifier>(
      builder: (context, notifier, offNotifier, _) {
        List<Data> result = [];
        if (notifier.internetConnectionError == '' &&
            notifier.recipeError == '') {
          result = notifier.allRecipeData
              .where(
                (recipe) => recipe?.title?.toLowerCase()?.contains(query),
              )
              .toList();
        } else {
          result = offNotifier.recipeList
              .where(
                (recipe) => recipe?.title?.toLowerCase()?.contains(query),
              )
              .toList();
        }

        if (result.isEmpty) {
          return Empty(
            text: '',
            screen: 'search',
          );
        }

        return RecipeGrid(
          recipeList: result,
        );
      },
    );
  }
}
