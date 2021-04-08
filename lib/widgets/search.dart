import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
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
    return Consumer<AllRecipeNotifier>(
      builder: (context, notifier, _) {
        final results = notifier.allRecipeData
            .where(
              (recipe) => recipe.title.toLowerCase().contains(query),
            )
            .toList();
        if (notifier.allRecipeData.isEmpty || results.isEmpty) {
          return Empty(
            text: 'Recipe Item not Found.',
          );
        }

        return RecipeGrid(
          recipeList: results,
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
    return Consumer<AllRecipeNotifier>(
      builder: (context, notifier, _) {
        final result = notifier.allRecipeData
            .where(
              (recipe) => recipe?.title?.toLowerCase()?.contains(query),
            )
            .toList();

        if (notifier.allRecipeData.isEmpty || result.isEmpty) {
          return Empty(
            text: 'Search Recipe.',
          );
        }

        return RecipeGrid(
          recipeList: result,
        );
      },
    );
  }
}
