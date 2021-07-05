import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:flutter/cupertino.dart';
import 'package:ran_flutter_account/ran_flutter_account.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';

import '../my_router.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    String name = Provider.of<DangjianViewModel>(context, listen: false).myOrganization?.name;
//    String organizationUnitName = Provider.of<DangjianViewModel>(context, listen: false).myOrganization?.organizationUnitName;
//    int meetingListTotalCount = Provider.of<DangjianViewModel>(context, listen: false).meetingList?.totalCount;
//    int partyMemberListTotalCount = Provider.of<DangjianViewModel>(context, listen: false).partyMemberList?.totalCount;
    super.build(context);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "我的",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
//          centerTitle: true,
        backgroundColor: APPColors.app_main,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            tooltip: '设置',
            icon: Icon(
              Icons.settings,
              size: 21,
            ),
            color: Colors.white,
            onPressed: () {
              NavigatorUtils.push(context, MyRouter.setPage);
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Consumer<DangjianViewModel>(
    builder: (context, dangjianViewModel, child) {
    return Center(
        child: Column(
          children: [
            Stack(children: <Widget>[
              Positioned(
                  child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: APPColors.app_main,
                      ),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Padding(
//                            padding: EdgeInsets.only(
//                              top: 50,
//                            ),
//                            child: Text(
//                              "我的",
//                              style:
//                                  TextStyle(color: Colors.white, fontSize: 18),
//                            ),
//                          )
//                        ],
//                      ),
                    ),
//                    Container(
//                      height: 250,
//                      color: Colors.white,
//                      width: double.infinity,
//                    )
                  ],
                ),
              )),
              Container(
                width: width,
                height: 160,
                margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x80DCE7FA),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 8.0,
                        spreadRadius: 0.0),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        if(dangjianViewModel.myOrganization?.name==null){
                          NavigatorUtils.push(context, AccountRouter.login);
                        } else {
                          NavigatorUtils.push(context, MyRouter.myInfoPage);
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: LoadImage(
                                ConfigService.getApiUrl() +
                                    '/api/assets/common/' +
                                    "userid" +
                                    '/profilePicture',
                                holderImg: 'logo_icon',
                                height: 60.0,
                                width: 60.0,
                                fit: BoxFit.fill),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                  child: Text(
                                    dangjianViewModel.myOrganization?.name ?? '未登录',
                                    style: TextStyle(fontSize: 19.0),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 10.0, top: 3),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                dangjianViewModel.myOrganization?.organizationUnitName ?? "",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 15),
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    ,
                    Gaps.vGap16,
                    Gaps.vGap8,
                    Gaps.line,
                    Gaps.vGap16,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text('党员'),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              dangjianViewModel.partyMemberList?.totalCount != null ? dangjianViewModel.partyMemberList?.totalCount.toString() : '0',
                              style: TextStyle(
                                  color: APPColors.app_main,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text('人',
                                style: TextStyle(
                                    color: APPColors.app_main, fontSize: 12)),
                          ],
                        ),
                        Gaps.vLine,
                        Row(
                          children: [
                            Text('会议'),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              dangjianViewModel.meetingList?.totalCount != null ? dangjianViewModel.meetingList?.totalCount.toString() : '0',
                              style: TextStyle(
                                  color: APPColors.app_main,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text('次',
                                style: TextStyle(
                                    color: APPColors.app_main, fontSize: 12)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ]),
            Gaps.vGap16,
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ClickItem(
//                      iconWidget: Padding(
//                        padding: EdgeInsets.only(right: 5),
//                        child: Icon(CupertinoIcons.question_circle),
//                      ),
                    title: "意见反馈",
                    content: '',
                    onTap: () async {
                      var url =
                          'mailto:1107554233@qq.com?subject=红色e汇通%20意见反馈&body=';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        await Future.delayed(Duration(seconds: 1));
                        launch('https://github.com/csch961207',
                            forceSafariVC: false);
                      }
                    },
                  ),
                  ClickItem(
//                      iconWidget: Padding(
//                        padding: EdgeInsets.only(right: 5),
//                        child: Icon(Icons.thumb_up_off_alt),
//                      ),
                    title: "好评鼓励",
                    content: '',
                    onTap: () async {
                        LaunchReview.launch(
                            androidAppId: "com.example.dignite_dangjian_flutter_app",
                            iOSAppId: "1423981796");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );})
    );
  }
}
