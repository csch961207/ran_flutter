import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class FlowEventRow extends StatelessWidget {
  const FlowEventRow(
      {Key key, this.title, this.creationTime, this.content})
      : super(key: key);

  final String title;
  final String creationTime;
  final String content;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(9, 10, 18, 0),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: APPColors.app_main,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title ?? '',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
//                  Text(
//                    Utils.apiDaysFormat(DateTime.parse(creationTime)),
//                    style: TextStyle(
//                      fontSize: 13,
//                    ),
//                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
