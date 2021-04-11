import 'package:dorecipes/providers/offline_recipes.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/customDialogSnack.dart';
import 'package:dorecipes/widgets/empty_and_error_recipe.dart';
import 'package:dorecipes/widgets/loading_info.dart';
import 'package:dorecipes/widgets/recipe_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeBook extends StatefulWidget {
  @override
  _RecipeBookState createState() => _RecipeBookState();
}

class _RecipeBookState extends State<RecipeBook> {
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<OfflineNotifier>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe Book',
          style: TextStyle(
            color: kColorTeal,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        actions: notifier.recipeList.isEmpty
            ? null
            : [
                PopupMenuButton<int>(
                  key: _key,
                  elevation: 1,
                  onSelected: (_) {
                    CustomWidgets.buildDialog(
                        onPressed: () {
                          notifier.deleteAllRecipeFromDb().then(
                                (_) => Navigator.of(context).pop(),
                              );
                        },
                        context: context,
                        title: 'Delete Recipe Book?',
                        contentText:
                            'This action will delete all Recipe from Recipe Book.');
                  },
                  itemBuilder: (context) {
                    return <PopupMenuEntry<int>>[
                      PopupMenuItem(
                        child: const Text(
                          'Delete All',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.teal,
                          ),
                        ),
                        value: 0,
                      ),
                    ];
                  },
                )
              ],
      ),
      body: FutureBuilder(
        future: Provider.of<OfflineNotifier>(
          context,
          listen: false,
        ).fetchAndSetRecipe(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? LoadingInfo()
                : Consumer<OfflineNotifier>(
                    child: Empty(
                      text: 'Recipe Book is Empty.\n Start Adding!',
                    ),
                    builder: (context, notifier, child) =>
                        notifier.recipeList.length <= 0
                            ? child
                            : RecipeGrid(
                                recipeList: notifier.recipeList,
                              ),
                  ),
      ),
    );
  }
}
