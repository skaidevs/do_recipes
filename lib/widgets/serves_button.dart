import 'package:dorecipes/widgets/commons.dart';
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
      borderRadius: BorderRadius.all(
        Radius.circular(
          50.0,
        ),
      ),
      onTap: onTap,
      child: Container(
        width: 90.0,
        child: Padding(
          padding: const EdgeInsets.all(
            10.0,
          ),
          child: Center(
            child: Icon(
              iconData,
              size: 24,
              color: kColorTeal,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          /*border: Border.all(
            color: Theme.of(context).accentColor.withOpacity(0.1),
            width: 1,
          ),*/
          borderRadius: BorderRadius.all(
            Radius.circular(
              50.0,
            ),
          ),
        ),
      ),
    );
  }
}
