import 'package:dorecipes/providers/all_recipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingInfo extends StatefulWidget {
  @override
  _LoadingInfoState createState() => _LoadingInfoState();
}

class _LoadingInfoState extends State<LoadingInfo>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 1,
      duration: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllRecipeNotifier>(builder: (context, notifier, _) {
      _controller.forward().then(
            (_) => _controller.reverse(),
          );
      return FadeTransition(
        opacity: Tween(
          begin: .5,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeIn,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
