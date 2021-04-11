import 'package:flutter/foundation.dart';

class ShopListItem {
  final String id;
  final String title;
  final List items;

  ShopListItem({
    @required this.id,
    @required this.title,
    @required this.items,
  });
}

class ShoppingListNotifier with ChangeNotifier {
  Map<String, ShopListItem> _listItems;

  Map<String, ShopListItem> get listItems {
    return {..._listItems};
  }

  void addShopListItem({
    String recipeId,
    String title,
    List items,
  }) {
    if (_listItems.containsKey(recipeId)) {
      //return
    } else {
      _listItems.putIfAbsent(
        recipeId,
        () => ShopListItem(
          id: DateTime.now().toString(),
          title: title,
          items: items,
        ),
      );
    }
  }
}
