import 'package:daisyinthekitchen/screens/all_recipe.dart';
import 'package:daisyinthekitchen/screens/categories.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:flutter/material.dart';

class AllRecipeAndCategories extends StatefulWidget {
  @override
  _AllRecipeAndCategoriesState createState() => _AllRecipeAndCategoriesState();
}

class _AllRecipeAndCategoriesState extends State<AllRecipeAndCategories>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  Widget getTabBar() {
    return TabBar(controller: _tabController, tabs: [
      Tab(
        icon: Icon(Icons.new_releases),
        text: "All Recipe",
      ),
      Tab(
        icon: Icon(Icons.category),
        text: "Categories",
      ),
    ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: _tabController, children: <Widget>[
      AllRecipe(),
      Categories(),
    ]);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: getTabBar(),
        ),
      ),
      body: getTabBarPages(),
    );
  }
}
