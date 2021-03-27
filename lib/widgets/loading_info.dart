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
        child: Icon(
          Icons.local_activity,
          size: 30.0,
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
