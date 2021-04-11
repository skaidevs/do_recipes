import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';

class CustomWidgets {
  CustomWidgets._();
  static buildSnackBar({BuildContext context, String message}) {
    final snackBar = SnackBar(
      duration: Duration(
        seconds: 1,
      ),
      backgroundColor: Colors.black87,
      behavior: SnackBarBehavior.floating,
      content: Text(
        '$message',
        style: TextStyle(
          color: kColorWhite,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static buildDialog({
    BuildContext context,
    String title,
    String contentText,
    Function onPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          content: Text(
            contentText,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text(
                "CANCEL",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "DELETE ALL",
                style: TextStyle(),
              ),
              onPressed: onPressed,
            ),
          ],
        );
      },
    );
  }
}
