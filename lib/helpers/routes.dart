import 'package:flutter/material.dart';

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var begin = Offset(0.0, 0.4);
    var end = Offset.zero;
    var curve = Curves.ease;

    var tween = Tween(
      begin: begin,
      end: end,
    ).chain(
      CurveTween(
        curve: curve,
      ),
    );

    /* return ScaleTransition(
      scale: animation,
      child: child,
    );*/
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
