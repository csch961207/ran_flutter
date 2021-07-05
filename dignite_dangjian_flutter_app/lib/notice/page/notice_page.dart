import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

import '../notice_router.dart';
///
class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
          title: Text(
            "通知",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
//          centerTitle: true,
          backgroundColor: APPColors.app_main,
          iconTheme: IconThemeData(color: Colors.white)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.vGap10,
            Column(
              children: List.generate(
                  1,
                  (index) => GestureDetector(
                    onTap: () async {
                      NavigatorUtils.push(context,
                          '${NoticeRouter.noticeDetailsPage}?id=${""}');
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                        child: LoadAssetImage('account-logo',
                                            height: 20.0,
                                            fit: BoxFit.fill,
                                            format: 'png'),
                                      ),
                                    ),
                                    Gaps.hGap4,
                                    Text(
                                      "已签收",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "7天前",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            Gaps.vGap8,
                            Gaps.line,
                            Gaps.vGap8,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "2021年党建思政工作专题会议",
                                  style: TextStyle(fontSize: 17),
                                  maxLines: 20,
                                ),
                                Gaps.vGap4,
                              ],
                            ),
                            Gaps.hGap8,
                            Gaps.vGap4,
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                              ),
                            ),
                            Gaps.vGap8,
                            Gaps.line,
                            Gaps.vGap8,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gaps.hGap4,
                                    Text(
                                      "查看详情",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ],
                        )),
                  )
                      ),
            )
          ],
        ),
      ),
    );
  }
}
