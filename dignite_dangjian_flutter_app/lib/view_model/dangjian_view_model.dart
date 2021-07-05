
import 'package:dignite_dangjian_flutter_app/meeting/meeting_repository.dart';
import 'package:dignite_dangjian_flutter_app/meeting/model/meeting_list_model.dart';
import 'package:dignite_dangjian_flutter_app/organizationManagement/model/my_organization.dart';
import 'package:dignite_dangjian_flutter_app/organizationManagement/organizationManagement_repository.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_list_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/partyMember_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DangjianViewModel with ChangeNotifier {

  MyOrganization myOrganization = new MyOrganization();
  PartyMemberList partyMemberList = new PartyMemberList();
  MeetingList meetingList = new MeetingList();
  int meetingListPage = 0;

  ///更新党员列表
  getPartyMemberList() async {
    PartyMemberList res = await PartyMemberRepository.getPartyMemberList(
        organizationUnitId: this.myOrganization.organizationUnitId,
        skipCount: 0);
    this.partyMemberList = res;
    notifyListeners();
  }

  ///获取我的党组织
  getMyOrganization() async {
    MyOrganization res = await OrganizationManagementRepository.getMyOrganization();
    this.myOrganization = res;
    notifyListeners();
  }

  ///更新会议列表
  getMeetingList() async {
    meetingListPage = 0;
    MeetingList res = await MeetingRepository.getMeetingList(
        organizationId: this.myOrganization.organizationUnitId,
        skipCount: meetingListPage * 20,maxResultCount: 20);
    this.meetingList = res;
    notifyListeners();
  }
  getNextPageMeetingList() async {
    meetingListPage++;
    MeetingList res = await MeetingRepository.getMeetingList(
        organizationId: this.myOrganization.organizationUnitId,
        skipCount: meetingListPage * 20,maxResultCount: 20);
    this.meetingList.items.addAll(res.items);
    notifyListeners();
    return res;
  }
}
