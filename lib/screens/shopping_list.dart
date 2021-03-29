import 'package:dorecipes/helpers/ingredient_database.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/empty_and_error_recipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    StreamBuilder<List<DownloadRecipeIngredientData>> _buildDownloadRecipe(
        BuildContext context) {
      final dao = Provider.of<RecipeIngredientDao>(context, listen: false);
      final _allRecipeNotifier =
          Provider.of<AllRecipeNotifier>(context, listen: false);
      return StreamBuilder(
          stream: dao.watchDownloadRecipes(),
          builder: (context,
              AsyncSnapshot<List<DownloadRecipeIngredientData>> snapshot) {
            final downloadRecipes = snapshot.data ?? [];

            if (snapshot.data == null) {
              return Container();
            } else if (downloadRecipes.isEmpty) {
              return const Empty(
                  text: 'You don\'t have any shopping list yet!');
            } else {
              return ListView.builder(
                key: const PageStorageKey<String>('shopping_list_key'),
                itemCount: downloadRecipes.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(4.0),
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final itemRecipeDownload = downloadRecipes[index];
                  final regExp =
                      new RegExp(r'(?:\[)?(\[[^\]]*?\](?:,?))(?:\])?');
                  final input = downloadRecipes[index].ingredients;
                  final _ingredients = regExp
                      .allMatches(input)
                      .map((m) => m.group(1))
                      .map((String item) =>
                          item.replaceAll(new RegExp(r'[\[\]]'), ''))
                      .toList();

                  return Container(
                    child: Card(
                      child: ListTile(
                        title: Text(
                          '${itemRecipeDownload.title}',
                          style: TextStyle(
                            color: kColorDKGreen,
                            fontSize: 20.0,
                            fontFamily: kBalooTamma2,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _ingredients[_allRecipeNotifier.activeServe]
                                  .isEmpty
                              ? 'N/A'
                              : _ingredients[_allRecipeNotifier.activeServe]
                                  .split(', ')
                                  .map<Widget>(
                                    (eachServes) => Text(
                                      '${eachServes.replaceAll(',', '')}',
                                      style: const TextStyle(
                                        fontFamily: kBalooTamma2,
                                        fontSize: 18.0,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          });
    }

    return Container(
      child: _buildDownloadRecipe(
        context,
      ),
    );
  }
}
