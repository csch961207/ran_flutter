import 'meeting_model.dart';

class MeetingMinutes {
  String id;
  String creationTime;
  String creatorId;
  String meetingId;
  Meeting meeting;
  String title;
  String content;

  MeetingMinutes(
      {this.id,
        this.creationTime,
        this.creatorId,
        this.meetingId,
        this.meeting,
        this.title,
        this.content});

  MeetingMinutes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationTime = json['creationTime'];
    creatorId = json['creatorId'];
    meetingId = json['meetingId'];
    meeting =
    json['meeting'] != null ? new Meeting.fromJson(json['meeting']) : null;
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['meetingId'] = this.meetingId;
    if (this.meeting != null) {
      data['meeting'] = this.meeting.toJson();
    }
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}