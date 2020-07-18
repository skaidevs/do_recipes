import 'package:daisyinthekitchen/models/recipe.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:flutter/material.dart';

class TimeCalDifficulty extends StatelessWidget {
  const TimeCalDifficulty({
    Key key,
    @required Recipe loadedRecipe,
  })  : _loadedRecipe = loadedRecipe,
        super(key: key);

  final Recipe _loadedRecipe;
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
              'PREP ${_loadedRecipe.time}',
              style: TextStyle(
                color: kColorGrey,
                fontSize: 12.0,
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
              '${_loadedRecipe.calories} CALS',
              style: TextStyle(
                color: kColorGrey,
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(
                Icons.ac_unit,
                size: 18,
                color: kColorGrey,
              ),
            ),
            Text(
              '${_loadedRecipe.difficulty} DIFFICULTY',
              style: TextStyle(
                color: kColorGrey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
