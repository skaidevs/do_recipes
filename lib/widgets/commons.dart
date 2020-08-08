import 'package:flutter/material.dart';

const Color kColorDKGreen = Color(0xFF029D75);
const Color kColorGrey = Colors.grey;
const Color kColorWhite = Colors.white;
const String kRobotoCondensed = 'RobotoCondensed';

Text kRecipeTexts({
  String text,
}) {
  return Text(
    text,
    style: TextStyle(
      //color: kColorDKGreen,
      fontSize: 24.0,
      fontFamily: kRobotoCondensed,
      fontWeight: FontWeight.bold,
      //fontStyle: FontStyle.italic,
    ),
  );
}
