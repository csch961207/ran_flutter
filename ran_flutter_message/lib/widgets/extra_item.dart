import 'package:flutter/material.dart';

//https://www.jianshu.com/p/821ab43b5ebe
class ExtraItemContainer extends StatefulWidget {
  ExtraItemContainer(
      {Key key,
      this.text,
      this.leadingIconPath,
      @required this.onTab})
      : super(key: key);

  final Function onTab;
  final String text;

  final String leadingIconPath;

  _ExtraItemContainerState createState() => _ExtraItemContainerState();
}

class _ExtraItemContainerState extends State<ExtraItemContainer> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    print("_handleTapDown");
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    print("_handleTapUp");

    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    print("_handleTapCancel");

    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    print("_handleTap");

    widget.onTab();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTap: _handleTap,
            onTapCancel: _handleTapCancel,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Image.asset(
                widget.leadingIconPath,
                width: 35,
                height: 35,
              ),
              // Padding(padding: EdgeInsets.only(left: 15)),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(widget.text,
              style: TextStyle(fontSize: 12.0, color: Colors.black54)),
        ],
      ),
    );
  }
}
