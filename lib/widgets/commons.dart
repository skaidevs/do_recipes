import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const Color kColorDKGreen = Color(0xFF029D75);
const Color kColorTeal = Colors.teal;
const Color kColorGrey = Colors.grey;
const Color kColorWhite = Colors.white;
const String kBalooTamma2 = 'BalooTamma2';

Text kRecipeTexts({
  String text,
}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30.0,
    ),
  );
}

Future kFlutterToast({String msg, BuildContext context}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: kColorWhite,
      fontSize: 16.0);
}
