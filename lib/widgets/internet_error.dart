import 'package:dorecipes/helpers/check_internet_connection.dart';
import 'package:dorecipes/providers/all_recipe.dart';
import 'package:dorecipes/providers/bottom_navigator.dart';
import 'package:dorecipes/providers/category.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InternetError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer3<AllRecipeNotifier, BottomNavigation, CategoryNotifier>(
      builder: (context, notifier, bottomNotifier, catiNotifier, _) {
        return Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 180.0,
                  height: 180.0,
                  child: Image.asset(
                    'assets/images/internet_error.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Flexible(
                  child: Text(
                    'No Internet Connection.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(
                        0.7,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextButton.icon(
                    label: Text(
                      'Try again',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    icon: Icon(
                      Icons.refresh,
                      color: kColorTeal,
                      size: 30,
                    ),
                    onPressed: () {
                      checkInternetConnection().then((connected) async {
                        if (connected) {
                          await catiNotifier.refreshCategory();
                          await notifier.refreshRecipe();
                        }
                      });
                    }),
                SizedBox(
                  height: 36,
                ),
                ElevatedButton(
                  onPressed: () {
                    bottomNotifier.currentIndex = 2;
                  },
                  child: Text(
                    "Go To Recipe Book",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
