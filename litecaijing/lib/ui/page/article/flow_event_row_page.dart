import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:litecaijing/config/router_manger.dart';
import 'package:litecaijing/util/date_utils_.dart';

class FlowEventRow extends StatelessWidget {
  const FlowEventRow(
      {Key key, this.title, this.publishTime, this.url, this.description})
      : super(key: key);

  final String title;
  final String publishTime;
  final String description;
  final String url;
  @override
  Widget build(BuildContext context) {
    final Color dimColor = const Color(0xFFC5C5C5);
    final Color highlightColor = const Color(0xFF40BE7F);

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
                color: Colors.indigo,
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
                  Text(
                    Utils.apiDaysFormat(DateTime.parse(publishTime)),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  url != null && url != ""
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RouteName.webView, arguments: url);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.link,
                                size: 14,
                              ),
                              Text(
                                '原文链接',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
