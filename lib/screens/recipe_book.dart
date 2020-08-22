import 'package:daisyinthekitchen/helpers/recipe_database.dart';
import 'package:daisyinthekitchen/widgets/recipe_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeBook extends StatefulWidget {
  @override
  _RecipeBookState createState() => _RecipeBookState();
}

class _RecipeBookState extends State<RecipeBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildDownloadRecipe(
        context,
      ),
    );
  }

  StreamBuilder<List<DownloadRecipe>> _buildDownloadRecipe(
      BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return StreamBuilder(
        stream: database.watchDownloadRecipes,
        builder: (context, AsyncSnapshot<List<DownloadRecipe>> snapshot) {
          final downloadRecipes = snapshot.data ?? List();

          return GridView.builder(
            itemCount: downloadRecipes.length,
            itemBuilder: (context, index) {
              final itemRecipeDownload = downloadRecipes[index];
              return _buildListItem(itemRecipeDownload, database);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 3.4,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            padding: const EdgeInsets.all(4.0),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
          );
        });
  }

  Widget _buildListItem(
    DownloadRecipe downloadRecipe,
    AppDatabase database,
  ) {
    return RecipeGridItem(
      id: downloadRecipe.id.toString(),
      title: downloadRecipe.title,
      duration: downloadRecipe.duration,
      imageUrl: downloadRecipe.imageUri,
    );
  }
}
