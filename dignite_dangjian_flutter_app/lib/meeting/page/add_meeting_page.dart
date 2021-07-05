import 'package:dignite_dangjian_flutter_app/meeting/model/add_meeting_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/add_meeting_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/meeting_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_list_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/partyMember_repository.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ran_flutter_core/utils/jhPickerTool.dart';

import '../meeting_repository.dart';

class AddMeetingPage extends StatefulWidget {
  @override
  _AddMeetingPageState createState() => _AddMeetingPageState();
}

class _AddMeetingPageState extends State<AddMeetingPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  final _titleController = TextEditingController();
  final FocusNode _titleNodeText = FocusNode();
  final _remarksController = TextEditingController();
  final FocusNode _remarksNodeText = FocusNode();
  AddMeetingItem addMeetingItem = new AddMeetingItem();
  AddMeetingUsers addMeetingUsers = new AddMeetingUsers();
  List<int> selectValue = [];
  List<PartyMember> partyMemberList = [];

  void loadData() async {
    try{
      String organizationUnitId =
          Provider.of<DangjianViewModel>(context, listen: false)
              .myOrganization
              ?.organizationUnitId;
      EasyLoading.show();
      PartyMemberList partyMemberListRes =
      await PartyMemberRepository.getPartyMemberList(
          organizationUnitId: organizationUnitId,
          skipCount: 0);
      setState(() {
        partyMemberList = partyMemberListRes.items;
      });
      EasyLoading.dismiss();
    } catch(e,s){
      EasyLoading.dismiss();
      getErrorTips(e, s);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '创建会议',
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
                          TextFieldItem(
                              controller: _titleController,
                              focusNode: _titleNodeText,
                              title: "标题",
                              hintText: "请输入",
                              isRequired: true),
                          ClickItem(
                            isRequired: true,
                            title: "会议时间",
                            content: addMeetingItem.meetingTime ?? "",
                            widgetContent: addMeetingItem.meetingTime == null
                                ? Text("请选择",
                                    maxLines: 1,
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey))
                                : null,
                            onTap: () {
                              JhPickerTool.showDatePicker(context,
                                  dateType: DateType.YMD,
                                  title: "请选择会议时间",
                                  value: DateTime(
                                      new DateTime.now().year,
                                      new DateTime.now().month,
                                      new DateTime.now().day),
                                  clickCallback: (var str, var time, var year,
                                      var month, var item) {
                                print(str);
                                print(time);
                                print(year);
                                print(month);
                                print(item);
                                setState(() {
                                  addMeetingItem.meetingTime = str;
                                });
                              });
                            },
                          ),
                          ClickItem(
                            isRequired: true,
                            title: "参会人员",
                            content: selectValue.length != 0
                                ? "已选${selectValue.length.toString()}人"
                                : "",
                            widgetContent: selectValue.length == 0
                                ? Text("请选择",
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey))
                                : null,
                            onTap: () {
                              _showBottomSheet(context, '选择参会人', '');
                            },
                          ),
                        ],
                      ),
                    ),
//                    Container(
//                      margin: EdgeInsets.only(left: 5, right: 5),
//                      padding: EdgeInsets.all(15),
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(4.0)),
//                      child: InkWell(
//                        onTap: () {
//                          _showBottomSheet(context, '选择参会人', '');
//                        },
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Text(
//                              '参会人员',
//                              style: TextStyle(fontSize: 17),
//                            ),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.end,
//                              children: <Widget>[
//                                selectValue.length != 0
//                                    ? Text("已选${selectValue.length}人")
//                                    : Text("请选择",
//                                        maxLines: 1,
//                                        textAlign: TextAlign.right,
//                                        overflow: TextOverflow.ellipsis,
//                                        style: TextStyle(
//                                            fontSize: 14, color: Colors.grey)),
//                                Icon(
//                                  Icons.chevron_right,
//                                  size: 28,
//                                  color: Colors.grey,
//                                )
//                              ],
//                            )
//                          ],
//                        ),
//                      ),
//                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: const Text("备注", style: TextStyle(fontSize: 16)),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 15, right: 5, left: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
//                      textInputAction: TextInputAction.search,
                          key: const Key('c_text'),
                          controller: _remarksController,
                          focusNode: _remarksNodeText,
                          maxLines: 10,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 8.0, left: 12.0, right: 12.0, bottom: 8.0),
                            border: InputBorder.none,
                            hintText: '请输入内容',
                          ),
                          onChanged: (text) {},
                          onSubmitted: (text) {
                            FocusScope.of(context).unfocus();
                            print('submit $text');
                          },
                        )),
                  ],
                ),
              )),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
            child: RanButton(
              text: '提交',
//                isShape: true,
              onPressed: () async {
                try {
                  if (_titleController.text.isEmpty) {
                    ToastUtil.show("标题是必填项");
                    return;
                  }
                  if (addMeetingItem.meetingTime.isEmpty) {
                    ToastUtil.show("会议时间是必填项");
                    return;
                  }
                  if (addMeetingItem.meetingTime.isEmpty) {
                    ToastUtil.show("会议时间是必填项");
                    return;
                  }
                  this.addMeetingItem.title = _titleController.text;
                  String organizationUnitId =
                      Provider.of<DangjianViewModel>(context, listen: false)
                          .myOrganization
                          ?.organizationUnitId;
                  this.addMeetingItem.organizationId = organizationUnitId;
                  List<String> userIds = [];
                  for (var i = 0; i < selectValue.length; i++) {
                    userIds.add(partyMemberList[selectValue[i]].id);
                  }
                  if (userIds.isEmpty) {
                    ToastUtil.show("请选择参会人");
                    return;
                  }
                  addMeetingUsers.userIds = userIds;
//                  addMeetingItem.meetingTime = "2021-06-26 16:46:35.4543034";
                  print(addMeetingItem.toJson());
                  EasyLoading.show();
                  AddMeeting addMeeting = new AddMeeting(
                      meeting: addMeetingItem, meetingUsers: addMeetingUsers);
                  String code = await MeetingRepository.postMeeting(addMeeting);
                  EasyLoading.dismiss();
                  if (code == "200" || code == "204") {
                    ToastUtil.show('提交成功');
                    Provider.of<DangjianViewModel>(context, listen: false)
                        .getMeetingList();
                    NavigatorUtils.goBack(context);
                  }
                } catch (e, s) {
                  print(e.toString());
                  EasyLoading.dismiss();
                  getErrorTips(e, s, context: context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context, String title, String content) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
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
                        },
                        child: SizedBox(
//                      height: 16.0,
//                      width: 16.0,
                          child: Text(
                            '已选（${selectValue.length}）',
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
//                              NavigatorUtils.goBack(context);
//                              partyMemberList[i]
                          state(() {
                            selectValue.clear();
                            for (var i = 0; i < partyMemberList.length; i++) {
                              if (partyMemberList[i].partyMemberType == 1) {
                                selectValue.add(i);
                              }
                            }
                          });
                          setState(() {
                          });
                        },
                        child: SizedBox(
//                      height: 16.0,
//                      width: 16.0,
                          child: Text(
                            '在职党员',
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
                            partyMemberList.length,
                            (i) => InkWell(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(15),
//                                    decoration: BoxDecorations.bg_white,
                                    child: Row(
                                      children: <Widget>[
                                        Gaps.hGap16,
                                        Expanded(
                                          child: Text(partyMemberList[i].name),
                                        ),
                                        LoadAssetImage(
                                            selectValue.contains(i)
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
                                      if (selectValue.contains(i)) {
                                        selectValue.remove(i);
                                      } else {
                                        selectValue.add(i);
                                      }
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
