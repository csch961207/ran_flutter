class AddMeeting {
  AddMeetingItem meeting;
  AddMeetingUsers meetingUsers;

  AddMeeting({this.meeting, this.meetingUsers});

  AddMeeting.fromJson(Map<String, dynamic> json) {
    meeting =
    json['meeting'] != null ? new AddMeetingItem.fromJson(json['meeting']) : null;
    meetingUsers = json['meetingUsers'] != null
        ? new AddMeetingUsers.fromJson(json['meetingUsers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meeting != null) {
      data['meeting'] = this.meeting.toJson();
    }
    if (this.meetingUsers != null) {
      data['meetingUsers'] = this.meetingUsers.toJson();
    }
    return data;
  }
}

class AddMeetingItem {
  String title;
  String organizationId;
  String meetingTime;
  String remarks;

  AddMeetingItem({this.title, this.organizationId, this.meetingTime, this.remarks});

  AddMeetingItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    organizationId = json['organizationId'];
    meetingTime = json['meetingTime'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['organizationId'] = this.organizationId;
    data['meetingTime'] = this.meetingTime;
    data['remarks'] = this.remarks;
    return data;
  }
}

class AddMeetingUsers {
  List<String> userIds;

  AddMeetingUsers({this.userIds});

  AddMeetingUsers.fromJson(Map<String, dynamic> json) {
    userIds = json['userIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userIds'] = this.userIds;
    return data;
  }
}