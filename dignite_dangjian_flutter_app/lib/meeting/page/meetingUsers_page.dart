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

class MeetingUsersPage extends StatefulWidget {
  const MeetingUsersPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;
  @override
  _MeetingUsersPageState createState() => _MeetingUsersPageState();
}

class _MeetingUsersPageState extends State<MeetingUsersPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  MeetingItem meetingItem = new MeetingItem();
  Blobs blobs = new Blobs();
  int selectValue = 0;
  final picker = ImagePicker();

  void loadData() async {
    EasyLoading.show();
    try {
      MeetingItem res = await MeetingRepository.getMeeting(widget.id);
      Blobs blobsRes = await AssetsRepository.fetchBlobsFileList(
          "dangjian-meet-pictures", widget.id);
      setState(() {
        meetingItem = res;
        blobs = blobsRes;
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
          '参会人员',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: APPColors.app_main,
        iconTheme: IconThemeData(color: Colors.white),
//        elevation: 1.0,
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
                        children: List.generate(
                          meetingItem.meetingUsers?.length ?? 0,
                          (index) => ClickItem(
                            title: meetingItem
                                    .meetingUsers[index].partyMember?.name ??
                                "",
                            content: meetingItem.meetingUsers[index].isSignIn !=
                                        null &&
                                    meetingItem.meetingUsers[index].isSignIn
                                ? "已签到"
                                : "未签到",
                              onLongPress: (){
                              showElasticDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return BaseDialog(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                             "将要设置未签到",
                                            textAlign: TextAlign.center),
                                      ),
                                      onPressed: () async {
                                        NavigatorUtils.goBack(context);
                                        EasyLoading.show();
                                        try {
                                          String code =
                                              await MeetingRepository.putSignIn(
                                                  meetingItem
                                                      .meetingUsers[index].id,
                                                  false,"");
                                          EasyLoading.dismiss();
                                          if (code == "200" || code == "204") {
                                            loadData();
                                            Provider.of<DangjianViewModel>(
                                                    this.context,
                                                    listen: false)
                                                .getMeetingList();
                                            EasyLoading.dismiss();
                                            ToastUtil.show('提交成功');
                                          }
                                          EasyLoading.dismiss();
                                        } catch (e, s) {
                                          print(e.toString());
                                          EasyLoading.dismiss();
                                          getErrorTips(e, s,
                                              context: this.context);
                                        }
                                      },
                                    );
                                  });
                              },
                            onTap: () async {
                              if(meetingItem.meetingUsers[index].isSignIn ==
                                  null ||
                                  !meetingItem.meetingUsers[index].isSignIn){
                                _showBottomSheet(context,"现场照片","",index);
                              } else {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        new PhotoViewSimpleScreen(
                                          imageProvider:
                                          NetworkImage(ConfigService.getApiUrl() +
                                              "/host/" +
                                              "MeetingPicture/" +
                                              meetingItem.meetingUsers[index].pictureBlobName),
                                          heroTag: 'simple',
                                        )));
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )),
//          Container(
//            color: Colors.white,
//            padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
//            child: Container(
//              child: RanButton(
//                text: '现场照片人脸识别',
//                onPressed: () async {
//                  EasyLoading.show();
//                  try {
//                    var res = await MeetingRepository.putAutoSignIn(
//                        widget.id, null);
//                    if (res == "200" || res == "204") {
//                      await Provider.of<DangjianViewModel>(this.context,
//                          listen: false)
//                          .getMeetingList();
//                      ToastUtil.show('自动识别已完成');
//                      EasyLoading.dismiss();
//                    }
//                    EasyLoading.dismiss();
//                  } catch (e, s) {
//                    print(e.toString());
//                    EasyLoading.dismiss();
////                    getErrorTips(e, s, context: this.context);
//                  }
//
//                },
//              ),
//            ),
//          ),
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context, String title, String content,index) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context1, state) {
          ///这里的state就是setState
          return Container(
              height: 450,
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Container(
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: InkWell(
                            onTap: () {
                              NavigatorUtils.goBack(context);
                              setState(() {
                              });
                            },
                            child: SizedBox(
//                      height: 16.0,
//                      width: 16.0,
                              child: Text(
                                '取消',
                                style: TextStyle(color: APPColors.app_main),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              NavigatorUtils.goBack(context);
//                              partyMemberList[i]
                                  showElasticDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return BaseDialog(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                             "确定将要此照片作为本人的会议到场依据吗？",
                                            textAlign: TextAlign.center),
                                      ),
                                      onPressed: () async {
                                        NavigatorUtils.goBack(context);
                                        EasyLoading.show();
                                        try {
                                          String code =
                                              await MeetingRepository.putSignIn(
                                                  meetingItem
                                                      .meetingUsers[index].id,
                                                  meetingItem
                                                              .meetingUsers[
                                                                  index]
                                                              .isSignIn !=
                                                          null
                                                      ? !meetingItem
                                                          .meetingUsers[index]
                                                          .isSignIn
                                                      : true,blobs.items[selectValue].blobName);
                                          EasyLoading.dismiss();
                                          if (code == "200" || code == "204") {
                                            loadData();
                                            Provider.of<DangjianViewModel>(
                                                    this.context,
                                                    listen: false)
                                                .getMeetingList();
                                            EasyLoading.dismiss();
                                            ToastUtil.show('提交成功');
                                          }
                                          EasyLoading.dismiss();
                                        } catch (e, s) {
                                          print(e.toString());
                                          EasyLoading.dismiss();
                                          getErrorTips(e, s,
                                              context: this.context);
                                        }
                                      },
                                    );
                                  });
                              setState(() {
                              });
                            },
                            child: SizedBox(
//                      height: 16.0,
//                      width: 16.0,
                              child: Text(
                                '选择照片',
                                style: TextStyle(color: APPColors.app_main),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Gaps.line,
                    Container(
                      height: 392,
                      color: Color(0xFFf3f4f5),
                      child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                blobs.items?.length ?? 0,
                                    (i) => InkWell(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(15),
//                                    decoration: BoxDecorations.bg_white,
                                    child: Row(
                                      children: <Widget>[
                                        Gaps.hGap16,
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20, top: 10, bottom: 10),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(5)),
                                              child: LoadImage(
                                                  ConfigService.getApiUrl() +
                                                      "/host/" +
                                                      blobs.items[i].containerName +
                                                      "/" +
                                                      blobs.items[i].blobName,
//                                    height: 90.0,
                                                  holderImg: 'picture_failed',
                                                  fit: BoxFit.fitWidth,
                                                  format: 'png'),
                                            ),
                                          ),
                                        ),
                                        LoadAssetImage(
                                            selectValue == i
                                                ? "xz"
                                                : "xztm",
                                            width: 21.0,
                                            height: 21.0),
                                        Gaps.hGap16,
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    state(() {
                                      selectValue = i;
                                    });
                                    setState(() {
                                    });
                                  },
                                ))),
                      ),
                    )
                  ])));
        });
      },
    );
  }
}
