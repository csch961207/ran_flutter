import 'package:flutter/material.dart';

import 'skeleton.dart';

class ArticleSkeletonItem extends StatelessWidget {
  final int index;

  ArticleSkeletonItem({this.index: 0});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      decoration: BoxDecoration(
          border: Border(
              bottom: Divider.createBorderSide(context,
                  width: 0.7, color: Colors.redAccent))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 6.5,
                      width: width * 0.6,
                      decoration: SkeletonDecoration(isDark: isDark),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 6.5,
                      width: width * 0.6,
                      decoration: SkeletonDecoration(isDark: isDark),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 6.5,
                      width: width * 0.6,
                      decoration: SkeletonDecoration(isDark: isDark),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 8,
                      width: 30,
                      decoration: SkeletonDecoration(isDark: isDark),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 0,
                      ),
                    ),
                    Container(
                      height: 8,
                      width: 50,
                      decoration: SkeletonDecoration(isDark: isDark),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding (
            padding: EdgeInsets.fromLTRB(1, 10, 1, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
              child: Container(
                height: 70,
                width: 100,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
