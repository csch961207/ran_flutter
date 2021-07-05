import 'package:dignite_dangjian_flutter_app/meeting/model/add_meeting_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/add_meeting_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/meeting_item_model.dart';
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

class EditMeetingPage extends StatefulWidget {
  const EditMeetingPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;
  @override
  _EditMeetingPageState createState() => _EditMeetingPageState();
}

class _EditMeetingPageState extends State<EditMeetingPage> {
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


  void loadData() async {
    EasyLoading.show();
    try{
      MeetingItem res = await MeetingRepository.getMeeting(widget.id);
      addMeetingItem = AddMeetingItem.fromJson(res.meeting.toJson());
      _titleController.text = addMeetingItem.title;
      _remarksController.text = addMeetingItem.remarks;
      addMeetingItem.meetingTime = addMeetingItem.meetingTime != null
          ? Utils.daysFormat(
          DateTime.parse(addMeetingItem.meetingTime))
          : "";
      setState(() {
      });
      EasyLoading.dismiss();
    } catch(e,s){
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '编辑会议',
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
                        ],
                      ),
                    ),
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
                  EasyLoading.show();
                  this.addMeetingItem.title = _titleController.text;
                  String organizationUnitId =
                      Provider.of<DangjianViewModel>(context, listen: false)
                          .myOrganization
                          ?.organizationUnitId;
                  this.addMeetingItem.organizationId = organizationUnitId;
                  print(addMeetingItem.toJson());
                  String code = await MeetingRepository.putMeeting(widget.id,addMeetingItem);
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
}
