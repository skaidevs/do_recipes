import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String text;

  const Empty({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontSize: 24.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.hourglass_empty,
              size: 50.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String text;

  const Error({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
