import 'package:flutter/material.dart';

const Color kColorDKGreen = Color(0xFF029D75);
const Color kColorGrey = Colors.grey;
const Color kColorWhite = Colors.white;

Text kRecipeTexts({
  String text,
}) {
  return Text(
    text,
    style: TextStyle(
      color: kColorDKGreen,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      //fontStyle: FontStyle.italic,
    ),
  );
}
