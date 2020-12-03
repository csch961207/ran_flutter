import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class RanButton extends StatelessWidget {
  const RanButton({
    Key key,
    this.text: "",
    this.isShape: false,
    this.width,
    this.height,
    this.fontSize,
    @required this.onPressed,
  }) : super(key: key);

  final bool isShape;
  final String text;
  final double width;
  final double height;
  final double fontSize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    return FlatButton(
      onPressed: onPressed,
      textColor: Colors.white,
      color: color,
      shape: isShape
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0),
            height: height ?? 48,
            width: width ?? double.infinity,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(fontSize: fontSize ?? 18),
            ),
          ),
        ],
      ),
    );
  }
}

/// 按钮样式封装
class RanButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  RanButtonWidget({this.child, this.onPressed});
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(5),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}
