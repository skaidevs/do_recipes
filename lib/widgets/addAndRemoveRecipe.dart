import 'package:dorecipes/helpers/recipe_database.dart';
import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/providers/offline_recipes.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:dorecipes/widgets/customDialogSnack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeBookmarkWidget extends StatefulWidget {
  final Data data;
  final bool isItemCard;
  RecipeBookmarkWidget({this.data, this.isItemCard});

  @override
  _RecipeBookmarkWidgetState createState() => _RecipeBookmarkWidgetState();
}

class _RecipeBookmarkWidgetState extends State<RecipeBookmarkWidget> {
  Future<bool> get isBookmark async {
    final rowsPresent = await DBHelper.queryForBookMarked(widget?.data?.id);
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
          future: isBookmark,
          initialData:
              false, // you can define an initial value while the db returns the real value
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return const Icon(Icons.error,
                  color: Colors.red); //just in case the db return an error
            return widget.isItemCard
                ? IconButton(
                    onPressed: () => notifier
                        .insertAndRemoveRecipeFromDB(widget?.data, context)
                        .then(
                      (isInDB) {
                        setState(() {});
                        if (isInDB) {
                          CustomWidgets.buildSnackBar(
                              context: context,
                              message: 'Removed from recipe book.');
                        } else {
                          CustomWidgets.buildSnackBar(
                              context: context,
                              message: 'Added to recipe book.');
                        }
                      },
                    ),
                    icon: Icon(
                      Icons.bookmark_outlined,
                      size: 22,
                      color: !snapshot.data ? kColorTeal : kColorGrey,
                    ),
                  )
                : SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: RawMaterialButton(
                      onPressed: () => notifier
                          .insertAndRemoveRecipeFromDB(widget?.data, context)
                          .then((isInDB) {
                        setState(() {});

                        if (isInDB) {
                          CustomWidgets.buildSnackBar(
                              context: context,
                              message: 'Removed from recipe book.');
                        } else {
                          CustomWidgets.buildSnackBar(
                              context: context,
                              message: 'Added to recipe book.');
                        }
                      }),
                      elevation: 1.0,
                      fillColor: Colors.black.withOpacity(
                        0.7,
                      ),
                      child: Icon(
                        Icons.bookmark_outlined,
                        size: 22,
                        color: !snapshot.data ? kColorTeal : kColorGrey,
                      ),
                      shape: CircleBorder(),
                    ),
                  );
          }),
    );
  }
}
