import 'package:flutter/material.dart';

const Color kColorDKGreen = Color(0xFF029D75);
const Color kColorGrey = Colors.grey;
const Color kColorWhite = Colors.white;

Padding kRecipeTexts({String text}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
  );
}
