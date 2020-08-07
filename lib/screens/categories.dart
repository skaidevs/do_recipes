import 'package:daisyinthekitchen/providers/category.dart';
import 'package:daisyinthekitchen/widgets/category_list.dart';
import 'package:daisyinthekitchen/widgets/empty_and_error_recipe.dart';
import 'package:daisyinthekitchen/widgets/loading_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<CategoryNotifier>(
        builder: (context, notifier, _) {
          if (notifier.isLoading) {
            return Center(
              child: LoadingInfo(),
            );
          }
          if (notifier.error.isNotEmpty) {
            return Center(
              child: Error(
                text: 'An Error Occurred!!',
              ),
            );
          }
          if (notifier.categoryListData.isEmpty) {
            return Empty(
              text: 'No Category to Show',
            );
          } else {
            return CategoryList(
              notifier: notifier,
            );
          }
        },
      ),
    );
  }
}
