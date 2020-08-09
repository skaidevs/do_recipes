import 'package:daisyinthekitchen/models/recipe.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:flutter/material.dart';

class TimeCalDifficulty extends StatelessWidget {
  const TimeCalDifficulty({
    Key key,
    @required Data loadedRecipe,
  })  : _loadedRecipe = loadedRecipe,
        super(key: key);

  final Data _loadedRecipe;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(
                Icons.access_time,
                size: 18,
                color: kColorGrey,
              ),
            ),
            Text(
              '${_loadedRecipe.duration}',
              style: TextStyle(
                fontFamily: kBalooTamma2,
                color: kColorGrey,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(
                Icons.show_chart,
                size: 18,
                color: kColorGrey,
              ),
            ),
            Text(
              '${_loadedRecipe.calories} Cals',
              style: TextStyle(
                fontFamily: kBalooTamma2,
                color: kColorGrey,
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(
                Icons.grain,
                size: 18,
                color: kColorGrey,
              ),
            ),
            Text(
              '${capitalize(_loadedRecipe.difficulty)} Difficulty',
              style: TextStyle(
                fontFamily: kBalooTamma2,
                color: kColorGrey,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
