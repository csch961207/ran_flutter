import 'package:flutter/material.dart';

class RanCard extends StatelessWidget {
  const RanCard(
      {Key key,
      @required this.child,
      this.color: Colors.white,
      this.shadowColor: const Color.fromRGBO(231, 231, 231, 1)})
      : super(key: key);

  final Widget child;
  final Color color;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                offset: Offset(0.0, 2.0),
                blurRadius: 4.0,
                spreadRadius: 0.0),
          ],
          border: Border.all(
            color: Colors.white,
          )),
      child: child,
    );
  }
}
