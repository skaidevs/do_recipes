import 'dart:math';

import 'package:dorecipes/helpers/scroll_behavior.dart';
import 'package:dorecipes/models/list_categories.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/providers/category.dart';
import 'package:dorecipes/providers/recipe_by_category.dart';
import 'package:dorecipes/screens/categories.dart';
import 'package:dorecipes/screens/recipes_by_category.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/empty_and_error_recipe.dart';
import 'package:dorecipes/widgets/header_card.dart';
import 'package:dorecipes/widgets/internet_error.dart';
import 'package:dorecipes/widgets/loading_info.dart';
import 'package:dorecipes/widgets/recipe_grid.dart';
import 'package:dorecipes/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipesAndCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Random random = Random();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
                expandedHeight: 80.0,
                elevation: 0.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'DO RECIPES',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: RecipeSearch(),
                        );
                      })
                ]),
          ];
        },
        body: Consumer2<AllRecipeNotifier, CategoryNotifier>(
          child: Empty(
            text: 'Recipe is Empty.',
          ),
          builder: (context, allRecipeNotifier, categoryNotifier, child) =>
              allRecipeNotifier.isLoading || categoryNotifier.isLoading
                  ? LoadingInfo()
                  : allRecipeNotifier.internetConnectionError.isNotEmpty
                      ? InternetError()
                      : allRecipeNotifier.recipeError.isNotEmpty ||
                              categoryNotifier.categoryError.isNotEmpty
                          ? ErrorPage(
                              text: 'An Error Occurred!!',
                            )
                          : allRecipeNotifier.allRecipeData.length <= 0
                              ? child
                              : ScrollConfiguration(
                                  behavior: ScrollConfigBehavior(),
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.only(
                                      top: 20.0,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        HeaderCard(
                                            recipeData: allRecipeNotifier
                                                .allRecipeData[random.nextInt(
                                          allRecipeNotifier
                                              .allRecipeData.length,
                                        )]),
                                        const SizedBox(
                                          height: 18.0,
                                        ),
                                        if (categoryNotifier.isCategoryLoaded)
                                          _viewAllCategory(context,
                                              categoryNotifier.categoryListData)
                                        else
                                          Container(),
                                        _buildCategoryText(
                                          categoryText: 'All Recipes',
                                          viewAll: '',
                                        ),
                                        RecipeGrid(
                                          recipeList:
                                              allRecipeNotifier.allRecipeData,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
        ),
      ),
    );
  }

  Widget _viewAllCategory(BuildContext context, List<Category> categoryData) =>
      Column(
        children: [
          _buildCategoryText(
              categoryText: 'Categories',
              viewAll: 'View All',
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Categories.routeName,
                );
              }),
          const SizedBox(
            height: 8.0,
          ),
          _buildHorizontalCategories(categoryData: categoryData),
          const SizedBox(
            height: 12.0,
          ),
        ],
      );

  Widget _buildCategoryText({
    String categoryText,
    String viewAll,
    Function onPressed,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryText,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                viewAll,
                style: TextStyle(
                  fontSize: 16.0,
                  color: kColorTeal,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildHorizontalCategories({
    List<Category> categoryData,
  }) =>
      SizedBox(
        height: 56.0,
        child: ScrollConfiguration(
          behavior: ScrollConfigBehavior(),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categoryData.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  onTap: () {
                    Map _data = {
                      'id': categoryData[index].id,
                      'name': categoryData[index].name,
                    };
                    _selectedCategory(
                      data: _data,
                      context: context,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                    ),
                    child: Center(
                      child: Text(
                        categoryData[index].name,
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kColorWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _selectedCategory({Map data, BuildContext context}) {
    final _notifier = Provider.of<RecipeByCategoryNotifier>(
      context,
      listen: false,
    );
    _notifier.loadRecipeByCategory(categoryId: data['id']);
    Navigator.of(context).pushNamed(
      RecipesByCategory.routeName,
      arguments: data,
    );
  }
}
