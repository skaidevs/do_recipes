import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/offline_recipes.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAndRemoveShoppingList extends StatefulWidget {
  final Data data;
  AddAndRemoveShoppingList(this.data);

  @override
  _AddAndRemoveShoppingListState createState() =>
      _AddAndRemoveShoppingListState();
}

class _AddAndRemoveShoppingListState extends State<AddAndRemoveShoppingList> {
  Future<bool> get isShoppingList async {
    final rowsPresent = await DBHelper.queryForShoppingList(widget?.data?.id);
    if (rowsPresent > 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OfflineNotifier>(
      builder: (context, notifier, _) => FutureBuilder<bool>(
          future: isShoppingList,
          initialData:
              false, // you can define an initial value while the db returns the real value
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return const Icon(Icons.error,
                  color: Colors.red); //just in case the db return an error
            return IconButton(
              onPressed: () =>
                  notifier.insertAndRemoveIngFromDB(widget?.data, context).then(
                        (_) => setState(() {}),
                      ),
              icon: Icon(
                Icons.add_shopping_cart_rounded,
                size: 22,
                color: !snapshot.data ? kColorTeal : kColorGrey,
              ),
            );
          }),
    );
  }
}
