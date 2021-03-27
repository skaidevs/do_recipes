import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/empty_and_error_recipe.dart';
import 'package:dorecipes/widgets/recipe_grid.dart';
import 'package:dorecipes/widgets/recipe_grid_item.dart';
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
        if (notifier.allRecipeData.isEmpty) {
          return Center(
            child: Text('NO DATA'),
          );
        }

        final results = notifier.allRecipeData.where(
          (recipe) => recipe.title.toLowerCase().contains(query),
        );
        return Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            children: results
                .map<Widget>(
                  (recipe) => RecipeGrid(
                    notifier: notifier,
                  ),
                )
                .toList(),
          ),
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
          color: kColorWhite,
          fontSize: 20.0,
          fontFamily: kBalooTamma2,
        ),
      ),
      primaryIconTheme: theme.primaryIconTheme.copyWith(
        color: Colors.white,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<AllRecipeNotifier>(
      builder: (context, notifier, _) {
        if (notifier.allRecipeData.isEmpty) {
          return Empty(
            text: 'NO RECIPE TO SHOW \n IN SEARCH',
          );
        }

        final result = notifier.allRecipeData.where(
          (recipe) => recipe.title.toLowerCase().contains(query),
        );
        return Container(
          color: kColorWhite,
          child: result.toList().isEmpty
              ? Empty(
                  text: 'NO RECIPE TO SHOW \n IN SEARCH',
                )
              : GridView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) => RecipeGridItem(
                    id: result.toList()[index].id,
                    title: result.toList()[index].title,
                    duration: result.toList()[index].duration,
                    imageUrl: result.toList()[index].imageUrl,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 3.4,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  padding: const EdgeInsets.all(4.0),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                ),
        );
      },
    );
  }
}
