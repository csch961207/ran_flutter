import 'meetingMinutes_model.dart';
import 'meetingUsers_model.dart';
import 'meeting_model.dart';

class MeetingItem {
  Meeting meeting;
  List<MeetingMinutes> meetingMinutes;
  List<MeetingUsers> meetingUsers;

  MeetingItem({this.meeting, this.meetingMinutes, this.meetingUsers});

  MeetingItem.fromJson(Map<String, dynamic> json) {
    meeting =
    json['meeting'] != null ? new Meeting.fromJson(json['meeting']) : null;
    if (json['meetingMinutes'] != null) {
      meetingMinutes = new List<MeetingMinutes>();
      json['meetingMinutes'].forEach((v) {
        meetingMinutes.add(new MeetingMinutes.fromJson(v));
      });
    }
    if (json['meetingUsers'] != null) {
      meetingUsers = new List<MeetingUsers>();
      json['meetingUsers'].forEach((v) {
        meetingUsers.add(new MeetingUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meeting != null) {
      data['meeting'] = this.meeting.toJson();
    }
    if (this.meetingMinutes != null) {
      data['meetingMinutes'] =
          this.meetingMinutes.map((v) => v.toJson()).toList();
    }
    if (this.meetingUsers != null) {
      data['meetingUsers'] = this.meetingUsers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}