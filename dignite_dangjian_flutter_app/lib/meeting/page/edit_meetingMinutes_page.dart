import 'package:dignite_dangjian_flutter_app/meeting/model/add_meetingMinutes_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/meetingMinutes_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/add_partyMembers_model.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:provider/provider.dart';
import 'package:ran_flutter_core/utils/jhPickerTool.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../meeting_repository.dart';

class EditMeetingMinutesPage extends StatefulWidget {
  const EditMeetingMinutesPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;
  @override
  _EditMeetingMinutesPageState createState() => _EditMeetingMinutesPageState();
}

class _EditMeetingMinutesPageState extends State<EditMeetingMinutesPage> {

  AddMeetingMinutes addMeetingMinutes = new AddMeetingMinutes();

  final _titleController = TextEditingController();
  final FocusNode _titleNodeText = FocusNode();
  final _contentController = TextEditingController();
  final FocusNode _contentNodeText = FocusNode();

  MeetingMinutes meetingMinutes = new MeetingMinutes();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    EasyLoading.show();
    try{
      MeetingMinutes res = await MeetingRepository.getMeetingMinutes(widget.id);
      addMeetingMinutes = AddMeetingMinutes.fromJson(res.toJson());
      _titleController.text = addMeetingMinutes.title;
      _contentController.text = addMeetingMinutes.content;
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
          '添加会议纪要',
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
                      margin: EdgeInsets.only(top: 10, bottom: 15,right: 5,left: 5),
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
//                              title: "",
                              hintText: "请输入标题"),
                          TextField(
//                      textInputAction: TextInputAction.search,
                            key: const Key('c_text'),
                            controller: _contentController,
                            focusNode: _contentNodeText,
                            maxLines: 10,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  top: 8.0, left: 16.0, right: 16.0, bottom: 8.0),
                              border: InputBorder.none,
                              hintText: '请输入内容',
                            ),
                            onChanged: (text) {},
                            onSubmitted: (text) {
                              FocusScope.of(context).unfocus();
                              print('submit $text');
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
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
                EasyLoading.show();
                try {
                  this.addMeetingMinutes.title = _titleController.text;
                  this.addMeetingMinutes.content = _contentController.text;
                  this.addMeetingMinutes.meetingId = widget.id;
                  print(this.addMeetingMinutes.toJson());
                  String code = await MeetingRepository.putMeetingMinutes(widget.id,
                      this.addMeetingMinutes);
                  EasyLoading.dismiss();
                  if (code == "200" || code == "204") {
                    ToastUtil.show('提交成功');
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
