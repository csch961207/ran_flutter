class Meeting {
  String id;
  String title;
  String organizationId;
  String organizationName;
  String meetingTime;
  int shouldArriveQuantity;
  int actualQuantity;
  String remarks;

  Meeting(
      {this.id,
        this.title,
        this.organizationId,
        this.organizationName,
        this.meetingTime,
        this.shouldArriveQuantity,
        this.actualQuantity,
        this.remarks});

  Meeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    meetingTime = json['meetingTime'];
    shouldArriveQuantity = json['shouldArriveQuantity'];
    actualQuantity = json['actualQuantity'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['organizationId'] = this.organizationId;
    data['organizationName'] = this.organizationName;
    data['meetingTime'] = this.meetingTime;
    data['shouldArriveQuantity'] = this.shouldArriveQuantity;
    data['actualQuantity'] = this.actualQuantity;
    data['remarks'] = this.remarks;
    return data;
  }
}