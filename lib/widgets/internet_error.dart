import 'package:flutter/material.dart';

class InternetError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'No Internet Connection!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  //fontFamily: kBalooTamma2,
                  color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                  onPressed: () {
                    // _fetchDataAndCheckConnection();
                  }),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                // _bottomNavigation.currentIndex = 2;
              },
              child: Text(
                "Go to recipe book",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
