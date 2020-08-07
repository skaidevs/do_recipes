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

class ServesButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const ServesButton({
    Key key,
    this.onTap,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.white,
      onTap: onTap,
      child: Container(
        width: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              iconData,
              size: 20,
              color: kColorDKGreen,
            ),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
