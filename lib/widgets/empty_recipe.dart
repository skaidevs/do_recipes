import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String text;

  const Empty({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }
}
