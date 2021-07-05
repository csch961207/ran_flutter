import 'package:dignite_dangjian_flutter_app/meeting/meeting_repository.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/meeting_list_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/meeting_model.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../meeting_router.dart';

///
class MeetingPage extends StatefulWidget {
  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;

  List dataList = [1, 2, 3];

  @override
  void initState() {
    super.initState();
  }

  refresh() async {
    try {
      await Provider.of<DangjianViewModel>(context, listen: false)
          .getMeetingList();
      _refreshController.refreshCompleted();
    } catch (e,s) {
      print(e.toString());
      refreshController.refreshFailed();
      getErrorTips(e, s);
    }
  }

  loadMore() async {
    try {
      MeetingList meetingList = await Provider.of<DangjianViewModel>(context, listen: false)
          .getNextPageMeetingList();
      if (meetingList.items.isEmpty) {
        print('-------------------');
        print('空数据');
        print('-------------------');
        _refreshController.loadNoData();
      } else {
        _refreshController.refreshCompleted();
      }
//      setState(() {});
    } catch (e,s) {
      print(e.toString());
      refreshController.refreshFailed();
      getErrorTips(e, s);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xFFf5f5f5),
        appBar: AppBar(
          title: Text(
            "会议",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
//          centerTitle: true,
          backgroundColor: APPColors.app_main,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              tooltip: '添加',
              icon: Icon(
                CupertinoIcons.add,
                size: 21,
              ),
              color: Colors.white,
              onPressed: () {
                NavigatorUtils.push(context, MeetingRouter.addMeetingPage);
              },
            ),
          ],
        ),
        body: Consumer<DangjianViewModel>(
            builder: (context, dangjianViewModel, child) {
              if(dangjianViewModel.meetingList?.items?.length == null || dangjianViewModel.meetingList?.items?.length == 0){
                return ViewStateEmptyWidget(
                  image: Image.asset(
                    ImageHelper.wrapAssets('no_data.png')),
                  message: '',
                  onPressed: () {
                    refresh();
                  },
                );
              }
              return SmartRefresher(
                  controller: _refreshController,
                  header: WaterDropHeader(),
                  footer: RefresherFooter(),
                  onRefresh: refresh,
                  onLoading: loadMore,
                  enablePullUp: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gaps.vGap10,
                        Column(
                          children: childrenList(dangjianViewModel.meetingList),
                        )
                      ],
                    ),
                  )
                  );
            })
        );
  }

  List<Widget> childrenList(MeetingList meetingList) {
    List<Widget> childs = [];
    if (meetingList.items == null) {
      return childs;
    }
    for (var i = 0; i < meetingList.items.length; i++) {
      Meeting meetingItem = meetingList.items[i];
      childs.add(GestureDetector(
        onTap: () {
          NavigatorUtils.push(context,
              '${MeetingRouter.meetingDetailsPage}?id=${meetingItem.id}');
        },
        child: Container(
//                padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(231, 231, 231, 1),
                    offset: Offset(0.0, 2.0),
                    blurRadius: 4.0,
                    spreadRadius: 0.0),
              ],
            ),
            child: Slidable(
              key: ValueKey("$i"),
              actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
              actionExtentRatio: 0.25,
              child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                            meetingItem.organizationName,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 14,
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
                            meetingItem.title,
                            style: TextStyle(fontSize: 17),
                            maxLines: 20,
                          ),
                          Gaps.vGap4,
                          Text(
                            meetingItem.meetingTime != null
                                ? Utils.apiDaysFormat(
                                    DateTime.parse(meetingItem.meetingTime))
                                : "",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      Gaps.hGap8,
                      Gaps.vGap4,
                      Text(
                        "应到${meetingItem.shouldArriveQuantity}人，实际到场${meetingItem.actualQuantity}人",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                        ),
                      )
                    ],
                  )),
              secondaryActions: <Widget>[
                //右侧按钮列表
                IconSlideAction(
                  caption: '删除',
                  color: Colors.red,
                  icon: Icons.delete,
                  closeOnTap: true,
                  onTap: () {
                    showElasticDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return BaseDialog(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: const Text("你确定要删除吗？",
                                  textAlign: TextAlign.center),
                            ),
                            onPressed: () async {
                              NavigatorUtils.goBack(context);
                              try {
                                EasyLoading.show();
                                String code =
                                    await MeetingRepository.deleteMeeting(
                                        meetingItem.id);
                                if (code == "204" || code == "200") {
                                  await Provider.of<DangjianViewModel>(context,
                                      listen: false)
                                      .getMeetingList();
                                  EasyLoading.dismiss();
                                  ToastUtil.show('删除成功');
                                }
                                EasyLoading.dismiss();
                              } catch (e, s) {
                                EasyLoading.dismiss();
                                getErrorTips(e, s, context: context);
                                print(e);
                              }
                            },
                          );
                        });
                  },
                ),
              ],
            )),
      ));
    }
    return childs;
  }
}
