import 'package:dignite_dangjian_flutter_app/meeting/model/add_meeting_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/meetingMinutes_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/meetingUsers_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/meeting_item_model.dart';
import 'package:dignite_dangjian_flutter_app/meeting/widget/flow_event_row_page.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_list_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/partyMember_repository.dart';
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

class EditMeetingUsersPage extends StatefulWidget {
  const EditMeetingUsersPage({
    Key key,
    @required this.meetingId,
  }) : super(key: key);

  final String meetingId;
  @override
  _EditMeetingUsersPageState createState() => _EditMeetingUsersPageState();
}

class _EditMeetingUsersPageState extends State<EditMeetingUsersPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  MeetingItem meetingItem = new MeetingItem();
  AddMeetingUsers addMeetingUsers = new AddMeetingUsers();
  List<int> selectValue = [];
  List<PartyMember> partyMemberList = [];
  final picker = ImagePicker();

  void loadData() async {
    EasyLoading.show();
    try {
      String organizationUnitId =
          Provider.of<DangjianViewModel>(context, listen: false)
              .myOrganization
              ?.organizationUnitId;
      PartyMemberList partyMemberListRes =
          await PartyMemberRepository.getPartyMemberList(
              organizationUnitId: organizationUnitId, skipCount: 0);
      partyMemberList = partyMemberListRes.items;
      MeetingItem res = await MeetingRepository.getMeeting(widget.meetingId);
      print(res.toJson());
      meetingItem = res;
      selectValue.clear();
      for (var i = 0; i < partyMemberList.length; i++) {
        meetingItem.meetingUsers.forEach((item) {
          print("---------------------------------");
          print(item.userId);
          print(partyMemberList[i].id);
          print("---------------------------------");
              if(item.userId == partyMemberList[i].id){
                selectValue.add(i);
              }
        });
      }
      setState(() {});
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
                                    if (selectValue.contains(i)) {
                                      selectValue.remove(i);
                                    } else {
                                      selectValue.add(i);
                                    }
                                    setState(() {});
                                  },
                                )),
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
            child: Container(
              child: RanButton(
                text: '保存',
                onPressed: () async {
                  EasyLoading.show();
                  try {
                    List<String> userIds = [];
                    print(selectValue.toString());
                    for (var i = 0; i < selectValue.length; i++) {
                      userIds.add(partyMemberList[selectValue[i]].id);
                    }
                    if (userIds.isEmpty) {
                      ToastUtil.show("参会人不能为空");
                      return;
                    }
                    this.addMeetingUsers.userIds = userIds;
                    String code = await MeetingRepository.putMeetingUser(widget.meetingId,this.addMeetingUsers);
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
                    getErrorTips(e, s, context: this.context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
