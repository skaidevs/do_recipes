import 'package:dorecipes/providers/recipe_by_category.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/empty_and_error_recipe.dart';
import 'package:dorecipes/widgets/internet_error.dart';
import 'package:dorecipes/widgets/loading_info.dart';
import 'package:dorecipes/widgets/recipe_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipesByCategory extends StatelessWidget {
  static const routeName = '/all_recipe_byCategory';

  @override
  Widget build(BuildContext context) {
    final _categoryName = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${_categoryName['name']}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorTeal,
          ),
        ),
      ),
      body: Container(
        child: Consumer<RecipeByCategoryNotifier>(
          builder: (context, notifier, _) {
            Widget child;
            // print('Cat Data ${notifier.recipeDataByCategory.length}');
            if (notifier.isLoading) {
              child = LoadingInfo();
            } else if (notifier.error.isNotEmpty) {
              child = ErrorPage(
                text: 'An Error Occurred!!',
              );
            } else if (notifier.internetMessage.isNotEmpty) {
              child = InternetError();
            } else if (notifier.recipeByCategoryList.isNotEmpty) {
              child = RecipeGrid(
                data: notifier.recipeByCategoryList,
              );
            } else if (notifier.recipeByCategoryList.isEmpty) {
              child = Empty(
                text: 'No Recipe to Show',
              );
            }
            return child;
          },
        ),
      ),
    );
  }
}
