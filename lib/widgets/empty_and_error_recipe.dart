import 'package:daisyinthekitchen/screens/recipe_over_view.dart';
import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String text;

  const Empty({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: kBalooTamma2,
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
      ),
    );
  }
}

class CheckConnection extends StatelessWidget {
  final String text;

  const CheckConnection({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: kBalooTamma2,
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
            FlatButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DoRecipeHomePage()),
                );
                /*...*/
              },
              child: Text(
                "Go to recipe book",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.grey,
              fontFamily: kBalooTamma2,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
