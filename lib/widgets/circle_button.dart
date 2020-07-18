import 'package:daisyinthekitchen/widgets/commons.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({
    Key key,
    this.onTap,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 40.0;

    return InkResponse(
      highlightColor: Colors.white,
      splashColor: Colors.white,
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Theme.of(context).accentColor,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: kColorWhite,
        ),
      ),
    );
  }
}
