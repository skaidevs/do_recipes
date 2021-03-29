import 'package:dorecipes/helpers/ingredient_database.dart';
import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/providers/category.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/empty_and_error_recipe.dart';
import 'package:dorecipes/widgets/header_card.dart';
import 'package:dorecipes/widgets/internet_error.dart';
import 'package:dorecipes/widgets/loading_info.dart';
import 'package:dorecipes/widgets/recipe_category_card.dart';
import 'package:dorecipes/widgets/recipe_grid.dart';
import 'package:dorecipes/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllRecipeAndCategories extends StatefulWidget {
  @override
  _AllRecipeAndCategoriesState createState() => _AllRecipeAndCategoriesState();
}

class _AllRecipeAndCategoriesState extends State<AllRecipeAndCategories> {
  @override
  void initState() {
    //_fetchCategories();
    super.initState();
  }

  /*Future _fetchCategories() {
    final categoryNotifier =
        Provider.of<CategoryNotifier>(context, listen: false);
    return Future.delayed(Duration.zero)
        .then((_) => categoryNotifier.fetchCategories());
  }*/

  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<RecipeDao>(
      context,
      listen: false,
    );
    final daoIng = Provider.of<RecipeIngredientDao>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: kColorWhite,
      /*AppBar(
        flexibleSpace: SafeArea(
          child: getTabBar(),
        ),
      )*/
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kColorWhite,
        title: Text(
          'DO RECIPES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
        ),
        actions: <Widget>[
          /*StreamBuilder(
              stream: daoIng.watchDownloadRecipes(),
              builder: (context,
                  AsyncSnapshot<List<DownloadRecipeIngredientData>> snapshot) {
                final downloadRecipes = snapshot.data ?? [];
                if (snapshot.data == null) {
                  return Container();
                } else if (downloadRecipes.isEmpty) {
                  return Container();
                } else {
                  return _bottomNavigation.currentIndex == 1
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showIngDialog();
                          })
                      : Container(
                          child: Text('Whats here?'),
                        );
                }
              }),*/
          StreamBuilder(
              stream: dao.watchDownloadRecipes(),
              builder: (context, AsyncSnapshot<List<DownloadRecipe>> snapshot) {
                final downloadRecipes = snapshot.data ?? [];
                if (snapshot.data == null) {
                  return Container();
                } else if (downloadRecipes.isEmpty) {
                  return Container();
                } else {
                  return /*_bottomNavigation.currentIndex == 2
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDialog();
                          })
                      :
                     */
                      Container(
                    child: Text('And here!'),
                  );
                }
              }),
          /*_isConnectionReady == true
              ? IconButton(
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
              : Container(),*/
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
        ],
      ),
      body: Consumer2<AllRecipeNotifier, CategoryNotifier>(
        builder: (context, allRecipeNotifier, categoryNotifier, _) =>
            allRecipeNotifier.isLoading
                ? LoadingInfo()
                : allRecipeNotifier.internetConnectionError.isNotEmpty
                    ? InternetError()
                    : allRecipeNotifier.recipeError.isNotEmpty
                        ? ErrorPage(
                            text: 'An Error Occurred!!',
                          )
                        : SingleChildScrollView(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              right: 10.0,
                              left: 10.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                HeaderCard(),
                                const SizedBox(
                                  height: 18.0,
                                ),
                                if (categoryNotifier.isCategoryLoaded)
                                  _viewAllCategory()
                                else
                                  Container(),
                                _buildCategoryText(
                                    categoryText: 'All Recipes', viewAll: ''),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                RecipeGrid(
                                  notifier: allRecipeNotifier,
                                ),
                              ],
                            ),
                          ),
      ),
    );
  }

  Widget _viewAllCategory() => Column(
        children: [
          _buildCategoryText(categoryText: 'Categories', viewAll: 'View All'),
          const SizedBox(
            height: 8.0,
          ),
          RecipeCategoryCard(),
          const SizedBox(
            height: 12.0,
          ),
        ],
      );

  Widget _buildCategoryText({
    String categoryText,
    String viewAll,
  }) =>
      Row(
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
            onPressed: () {},
            child: Text(
              viewAll,
              style: TextStyle(
                fontSize: 16.0,
                color: kColorTeal,
              ),
            ),
          ),
        ],
      );
}
