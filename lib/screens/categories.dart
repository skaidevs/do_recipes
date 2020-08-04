import 'package:daisyinthekitchen/providers/category.dart';
import 'package:daisyinthekitchen/widgets/category_list.dart';
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

          return CategoryList(
            notifier: notifier,
          );
        },
      ),
    );
  }
}
