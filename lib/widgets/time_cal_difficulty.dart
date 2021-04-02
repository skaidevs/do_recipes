import 'package:dorecipes/models/recipe.dart';
import 'package:dorecipes/widgets/commons.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //crossAxisAlignment: CrossAxisAlignment.end,
      // mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        FittedBox(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.access_time_rounded,
                size: 40,
                color: Theme.of(context).accentColor,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                _loadedRecipe.duration,
                style: TextStyle(
                  fontFamily: kBalooTamma2,
                  color: kColorGrey,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        FittedBox(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.local_fire_department_rounded,
                size: 40,
                color: Theme.of(context).accentColor,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                '${_loadedRecipe.calories} Cals',
                style: TextStyle(
                  fontFamily: kBalooTamma2,
                  color: kColorGrey,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        FittedBox(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_loadedRecipe.difficulty == 'easy')
                Icon(
                  Icons.filter_1_rounded,
                  size: 40,
                  color: Theme.of(context).accentColor,
                )
              else if (_loadedRecipe.difficulty == 'medium')
                Icon(
                  Icons.filter_2_rounded,
                  size: 40,
                  color: Theme.of(context).accentColor,
                )
              else if (_loadedRecipe.difficulty == 'hard')
                Icon(
                  Icons.filter_3_rounded,
                  size: 40,
                  color: Theme.of(context).accentColor,
                ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                '${capitalize(_loadedRecipe.difficulty)}',
                style: TextStyle(
                  fontFamily: kBalooTamma2,
                  color: kColorGrey,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
