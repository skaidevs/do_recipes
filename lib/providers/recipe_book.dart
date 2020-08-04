import 'package:flutter/foundation.dart';

class RecipeBook {
  final String id;
  final List items;

  RecipeBook({
    @required this.id,
    @required this.items,
  });
}

class RecipeBookNotifier with ChangeNotifier {
/*  List<Recipe> _recipeItems = [];

  List<Recipe> get recipeItems {
    return [..._recipeItems];
  }*/
  Map<String, RecipeBook> _recipeItems;

  Map<String, RecipeBook> get recipeItems {
    return {..._recipeItems};
  }

  void addShopListItem({
    String recipeId,
    List items,
  }) {
    if (_recipeItems.containsKey(recipeId)) {
      //return
      print('Already contain RecipeBook');
    } else {
      _recipeItems.putIfAbsent(
        recipeId,
        () => RecipeBook(
          id: DateTime.now().toString(),
          items: items,
        ),
      );
      notifyListeners();
    }
  }

  void removeShopListItem(String recipeId) {
    _recipeItems.remove(recipeId);
    notifyListeners();
  }

  void clearShopListItem() {
    _recipeItems = {};
    notifyListeners();
  }
}
