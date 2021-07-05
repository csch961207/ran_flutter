import 'package:dignite_dangjian_flutter_app/meeting/model/meetingMinutes_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/meeting_item_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/widget/flow_event_row_page.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ran_flutter_assets/ran_flutter_assets.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../meeting_repository.dart';
import '../meeting_router.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MeetingDetailsPage extends StatefulWidget {
  const MeetingDetailsPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;
  @override
  _MeetingDetailsPageState createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends State<MeetingDetailsPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  MeetingItem meetingItem = new MeetingItem();
  final picker = ImagePicker();
  int blobsCount = 0;

  void loadData() async {
    EasyLoading.show();
    try {
      MeetingItem res = await MeetingRepository.getMeeting(widget.id);
      Blobs blobs = await AssetsRepository.fetchBlobsFileList(
          "dangjian-meet-pictures", widget.id);
      blobsCount = blobs.items?.length ?? 0;
      print(res.toJson());
      setState(() {
        meetingItem = res;
      });
      EasyLoading.dismiss();
    } catch (e, s) {
      print(e.toString());
      EasyLoading.dismiss();
      getErrorTips(e, s, context: this.context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    String userName = Provider.of<CoreViewModel>(context, listen: false)
        ?.applicationConfiguration
        ?.currentUser
        ?.userName;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '会议管理',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: APPColors.app_main,
        iconTheme: IconThemeData(color: Colors.white),
//        elevation: 1.0,
        actions: [
          IconButton(
            tooltip: '更多',
            icon: Icon(
              CupertinoIcons.ellipsis,
              size: 21,
            ),
            color: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,

                /// 使用true则高度不受16分之9的最高限制
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Container(
                    height: 160,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              NavigatorUtils.pushResult(context,
                                  '${MeetingRouter.editMeetingUsersPage}?meetingId=${widget.id}',
                                      (res) {
                                    loadData();
                                  });
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color(0xffe5e5e5))),
                                  ),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    '编辑参与人员',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                )
                              ],
                            )),
                        GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              NavigatorUtils.pushResult(context,
                                  '${MeetingRouter.editMeetingPage}?id=${widget.id}',
                                  (res) {
                                loadData();
                              });
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color(0xffe5e5e5))),
                                  ),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    '编辑会议',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                )
                              ],
                            )),
//                        GestureDetector(
//                            onTap: () async {
//                              Navigator.pop(context);
//                              showElasticDialog(
//                                  context: context,
//                                  barrierDismissible: false,
//                                  builder: (BuildContext context) {
//                                    return BaseDialog(
//                                      child: Padding(
//                                        padding:
//                                        const EdgeInsets.symmetric(horizontal: 16.0),
//                                        child: const Text("你确定要删除吗？",
//                                            textAlign: TextAlign.center),
//                                      ),
//                                      onPressed: () async {
//                                        NavigatorUtils.goBack(context);
//                                        try {
//                                          EasyLoading.show();
//                                          String code =
//                                          await MeetingRepository.deleteMeeting(
//                                              widget.id);
//                                          if (code == "204" || code == "200") {
//                                            await Provider.of<DangjianViewModel>(context,
//                                                listen: false)
//                                                .getMeetingList();
//                                            EasyLoading.dismiss();
//                                            ToastUtil.show('删除成功');
//                                          }
//                                          EasyLoading.dismiss();
//                                        } catch (e, s) {
//                                          EasyLoading.dismiss();
//                                          getErrorTips(e, s, context: context);
//                                          print(e);
//                                        }
//                                      },
//                                    );
//                                  });
//                            },
//                            child: Column(
//                              children: <Widget>[
//                                Container(
//                                  decoration: BoxDecoration(
//                                    color: Colors.white,
//                                  ),
//                                  alignment: Alignment.center,
//                                  height: 50,
//                                  child: Text(
//                                    '删除本次会议',
//                                    style: TextStyle(color: Colors.red, fontSize: 16),
//                                  ),
//                                )
//                              ],
//                            )),
                        Container(
                          color: Color(0xFFf5f5f5),
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    '取消',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      backgroundColor: Color(0xFFF3F2F2),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 16.0),
                      child: const Text("基本信息", style: TextStyle(fontSize: 16)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 15, right: 5, left: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClickItem(
                            title: "标题",
                            content: meetingItem?.meeting?.title ?? '',
//                            onTap: () {
//                            },
                          ),
                          ClickItem(
                            title: "会议时间",
                            content: meetingItem?.meeting?.meetingTime != null
                                ? Utils.apiDaysFormat(DateTime.parse(
                                    meetingItem?.meeting?.meetingTime))
                                : "",
//                            onTap: () {
//                            },
                          ),
                          ClickItem(
                            title: "参会人员",
                            content: meetingItem.meetingUsers != null
                                ? "${meetingItem.meetingUsers.length}人"
                                : "",
                            onTap: () {
                              NavigatorUtils.push(context,
                                  '${MeetingRouter.meetingUsersPage}?id=${meetingItem.meeting.id}');
                            },
                          ),
                          ClickItem(
                            title: "现场照片",
                            content: "${blobsCount.toString()}张",
                            onTap: () {
                              NavigatorUtils.pushResult(context,
                                  '${MeetingRouter.meetingPicturesPage}?meetingId=${widget.id}',
                                  (res) {
                                loadData();
                              });
//                              NavigatorUtils.push(context,
//                                  '${MeetingRouter.meetingUsersPage}?id=${meetingItem.meeting.id}');
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 16.0),
                      child: const Text("会议纪要", style: TextStyle(fontSize: 16)),
                    ),
                    Column(
                      children: [
                        meetingItem.meetingMinutes != null &&
                                meetingItem.meetingMinutes.length > 0
                            ? Stack(
                                fit: StackFit.loose,
                                children: <Widget>[
                                  // 左边的竖线
                                  Positioned(
                                    left: 26,
                                    top: 15,
                                    bottom: 15,
                                    child: VerticalDivider(
                                      width: 1,
                                      color: Color(0xFFe5e5e5),
                                    ),
                                  ),
                                  // 右边的事件列表
                                  Column(
                                    children: List.generate(
                                        meetingItem.meetingMinutes.length,
                                        (index) => Slidable(
                                              key: ValueKey("$index"),
                                              actionPane:
                                                  SlidableScrollActionPane(), //滑出选项的面板 动画
                                              actionExtentRatio: 0.25,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 15, 15, 0),
                                                child: FlowEventRow(
                                                    title: meetingItem
                                                        .meetingMinutes[index]
                                                        .title,
                                                    content: meetingItem
                                                        .meetingMinutes[index]
                                                        .content),
                                              ),
                                              secondaryActions: <Widget>[
                                                //右侧按钮列表
                                                IconSlideAction(
                                                  caption: '编辑',
                                                  color: Colors.blue,
                                                  icon: Icons.edit,
                                                  closeOnTap: true,
                                                  onTap: () {
                                                    NavigatorUtils.pushResult(
                                                        context,
                                                        '${MeetingRouter.editMeetingMinutesPage}?id=${meetingItem
                                                            .meetingMinutes[index].id}',
                                                        (res) {
                                                      loadData();
                                                    });
                                                  },
                                                ),
                                                IconSlideAction(
                                                  caption: '删除',
                                                  color: Colors.red,
                                                  icon: Icons.delete,
                                                  closeOnTap: true,
                                                  onTap: () {
                                                    showElasticDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return BaseDialog(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16.0),
                                                              child: const Text(
                                                                  "你确定要删除吗？",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              NavigatorUtils
                                                                  .goBack(
                                                                      context);
                                                              try {
                                                                EasyLoading
                                                                    .show();
                                                                String code = await MeetingRepository
                                                                    .deleteMeetingMinutes(meetingItem
                                                                        .meetingMinutes[
                                                                            index]
                                                                        .id);
                                                                if (code ==
                                                                        "204" ||
                                                                    code ==
                                                                        "200") {
                                                                  loadData();
                                                                  EasyLoading
                                                                      .dismiss();
                                                                  ToastUtil.show(
                                                                      '删除成功');
                                                                }
                                                                EasyLoading
                                                                    .dismiss();
                                                              } catch (e, s) {
                                                                EasyLoading
                                                                    .dismiss();
                                                                getErrorTips(
                                                                    e, s,
                                                                    context: this
                                                                        .context);
                                                                print(e);
                                                              }
                                                            },
                                                          );
                                                        });
                                                  },
                                                ),
                                              ],
                                            )),
                                  )
                                ],
                              )
                            : Container(
                                padding: EdgeInsets.all(20),
                                alignment: Alignment(0, 0),
                                child: Text('暂无记录'),
                              )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: const Text("备注", style: TextStyle(fontSize: 16)),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: 10, bottom: 15, right: 5, left: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              meetingItem?.meeting?.remarks ?? "无",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 17,
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
            child: Row(
              children: [
                Container(
                  child: Expanded(
                    child: RanButton(
                      text: '添加会议纪要',
                      onPressed: () {
                        NavigatorUtils.pushResult(context,
                            '${MeetingRouter.addMeetingMinutesPage}?meetingId=${widget.id}',
                            (res) {
                          loadData();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Expanded(
                    child: RanButton(
                      text: '拍摄现场照片',
                      onPressed: () {
                        NavigatorUtils.pushResult(context,
                            '${MeetingRouter.meetingPicturesPage}?meetingId=${widget.id}',
                                (res) {
                                loadData();
                            });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
