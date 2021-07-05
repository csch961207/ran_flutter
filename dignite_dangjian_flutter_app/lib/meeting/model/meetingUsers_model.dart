import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_model.dart';

import 'meeting_model.dart';

class MeetingUsers {
  String id;
  String meetingId;
  Meeting meeting;
  String userId;
  PartyMember partyMember;
  bool isSignIn;
  String pictureBlobName;

  MeetingUsers(
      {this.id,
        this.meetingId,
        this.meeting,
        this.userId,
        this.partyMember,
        this.isSignIn,
        this.pictureBlobName});

  MeetingUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetingId = json['meetingId'];
    meeting =
    json['meeting'] != null ? new Meeting.fromJson(json['meeting']) : null;
    userId = json['userId'];
    partyMember = json['partyMember'] != null
        ? new PartyMember.fromJson(json['partyMember'])
        : null;
    isSignIn = json['isSignIn'];
    pictureBlobName = json['pictureBlobName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meetingId'] = this.meetingId;
    if (this.meeting != null) {
      data['meeting'] = this.meeting.toJson();
    }
    data['userId'] = this.userId;
    if (this.partyMember != null) {
      data['partyMember'] = this.partyMember.toJson();
    }
    data['isSignIn'] = this.isSignIn;
    data['pictureBlobName'] = this.pictureBlobName;
    return data;
  }
}