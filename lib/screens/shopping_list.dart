import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/providers/offline_recipes.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/loading_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    /*StreamBuilder<List<DownloadRecipeIngredientData>> _buildDownloadRecipe(
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
    }*/

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping List',
          style: TextStyle(
            color: kColorTeal,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<OfflineNotifier>(
          context,
          listen: false,
        ).fetchAndSetIngredients(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? LoadingInfo()
                : Consumer<OfflineNotifier>(
                    child: Center(
                      child: const Text('You got Nothing ingredients!'),
                    ),
                    builder: (context, notifier, child) =>
                        notifier.ingredientList.length <= 0
                            ? child
                            : ListView.builder(
                                // key: const PageStorageKey<String>('shopping_list_key'),
                                itemCount: notifier.ingredientList.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(4.0),
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    _buildShoppingListItem(
                                        notifier?.ingredientList[index]),
                              ),
                  ),
      ),
    );
  }

  Widget _buildShoppingListItem(Data data) {
    final notifier = Provider.of<AllRecipeNotifier>(context, listen: false);
    final regExp = new RegExp(r'(?:\[)?(\[[^\]]*?\](?:,?))(?:\])?');
    final input = data.ingredients.toString();
    final _ingredients = regExp
        .allMatches(input)
        .map((m) => m.group(1))
        .map((String item) => item.replaceAll(new RegExp(r'[\[\]]'), ''))
        .toList();

    print(_ingredients);
    return Padding(
      key: Key(data.title),
      padding: const EdgeInsets.all(14.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kColorTeal.withOpacity(
            0.1,
          ),
          /*boxShadow: [
                                        BoxShadow(
                                          blurRadius: 1.0,
                                          color: kColorTeal.withOpacity(
                                            0.1,
                                          ),
                                        ),
                                      ],*/
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            collapsedBackgroundColor: kColorWhite,
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.access_time,
                  size: 22,
                  color: kColorTeal,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    left: 2.0,
                  ),
                  child: Text(
                    data.duration ?? 'N/A',
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontFamily: kBalooTamma2,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              data.title ?? 'N/A',
              style: TextStyle(fontSize: 22.0),
            ),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: _ingredients[notifier.activeServe].isEmpty
                    ? 'N/A'
                    : _ingredients[notifier.activeServe]
                        .split(', ')
                        .map<Widget>(
                          (eachServes) => Text(
                            '${eachServes.replaceAll(',', '')}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                            //textAlign: TextAlign.left,
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildItem1(String data) {
    return Text(data);
  }
}
