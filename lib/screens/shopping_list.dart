import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/providers/offline_recipes.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/empty_and_error_recipe.dart';
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
        actions: [
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {})
        ],
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
                    child: Empty(
                      text: 'Shopping List is Empty. \n Start Adding!',
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
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: _ingredients[notifier?.activeServe].isEmpty
                    ? 'N/A'
                    : _ingredients[notifier?.activeServe]
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
}
