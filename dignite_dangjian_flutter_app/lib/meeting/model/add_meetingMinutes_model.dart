class AddMeetingMinutes {
  String meetingId;
  String title;
  String content;

  AddMeetingMinutes({this.meetingId, this.title, this.content});

  AddMeetingMinutes.fromJson(Map<String, dynamic> json) {
    meetingId = json['meetingId'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meetingId'] = this.meetingId;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}