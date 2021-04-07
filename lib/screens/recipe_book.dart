import 'package:dorecipes/providers/offline_recipes.dart';
import 'package:dorecipes/widgets/loading_info.dart';
import 'package:dorecipes/widgets/recipe_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeBook extends StatefulWidget {
  @override
  _RecipeBookState createState() => _RecipeBookState();
}

class _RecipeBookState extends State<RecipeBook> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<OfflineNotifier>(
        context,
        listen: false,
      ).fetchAndSetRecipe(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? LoadingInfo()
              : Consumer<OfflineNotifier>(
                  child: Center(
                    child: const Text('You got Nothing !'),
                  ),
                  builder: (context, notifier, child) =>
                      notifier.recipeList.length <= 0
                          ? child
                          : RecipeGrid(
                              data: notifier.recipeList,
                              currentScreen: 'recipe_book',
                            ),
                ),
    );
  }

  /* StreamBuilder<List<DownloadRecipe>> _buildDownloadRecipe(
      BuildContext context) {
    final dao = Provider.of<RecipeDao>(context, listen: false);
    return StreamBuilder(
        stream: dao.watchDownloadRecipes(),
        builder: (context, AsyncSnapshot<List<DownloadRecipe>> snapshot) {
          final downloadRecipes = snapshot.data ?? List();

          if (snapshot.data == null) {
            return Container();
          } else if (downloadRecipes.isEmpty) {
            return Empty(
                text: 'You don\'t have any recipes in your recipe book yet!');
          } else {
            return GridView.builder(
              key: const PageStorageKey<String>('recipe_book_key'),
              itemCount: downloadRecipes.length,
              itemBuilder: (context, index) {
                final itemRecipeDownload = downloadRecipes[index];
                return _buildListItem(itemRecipeDownload, dao.db);
              },
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
            );
          }
        });
  }*/

  /*Widget _buildListItem(
    DownloadRecipe downloadRecipe,
    AppDatabase database,
  ) {
    return DownloadedRecipeGridItem(
      downloadRecipe: downloadRecipe,
    );
  }*/
}
