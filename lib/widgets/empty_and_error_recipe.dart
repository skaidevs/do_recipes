import 'package:dorecipes/screens/do_recipe_home.dart';
import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String text;
  final String screen;

  const Empty({Key key, this.text, this.screen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (screen == 'search')
            Container(
              //height: MediaQuery.of(context).size.height - 300.0,
              //width: double.infinity,
              child: Image.asset(
                'assets/images/search.png',
                fit: BoxFit.cover,
              ),
            )
          else if (screen == 'shopping_list')
            Container(
              //width: double.infinity,
              child: Image.asset(
                'assets/images/shopping_list.png',
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              // width: double.infinity,
              child: Image.asset(
                'assets/images/recipe_book.png',
                fit: BoxFit.cover,
              ),
            ),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ],
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
              child: const Icon(
                Icons.hourglass_empty,
                size: 50.0,
                color: Colors.grey,
              ),
            ),
            TextButton(
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

class ErrorPage extends StatelessWidget {
  final String text;

  const ErrorPage({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Image.asset(
            'assets/images/404_error.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
