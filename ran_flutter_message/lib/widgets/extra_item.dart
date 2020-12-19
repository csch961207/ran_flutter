import 'package:flutter/material.dart';

//https://www.jianshu.com/p/821ab43b5ebe
class ExtraItemContainer extends StatefulWidget {
  ExtraItemContainer(
      {Key key,
      this.text,
      this.leadingIconPath,
      @required this.onTab,
      @required this.onHandle})
      : super(key: key);

  final Function onTab;
  final String text;
  final String leadingIconPath;
  final Future<String> onHandle;

  _ExtraItemContainerState createState() => _ExtraItemContainerState();
}

class _ExtraItemContainerState extends State<ExtraItemContainer> {
  bool _highlight = false;

  void _handleTap() {
    print("_handleTap");

    widget.onTab();
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 4,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: _handleTap,
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
