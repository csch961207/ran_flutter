
import 'meeting_model.dart';

class MeetingList {
  List<Meeting> items;
  int totalCount;

  MeetingList({this.items, this.totalCount});

  MeetingList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Meeting>();
      json['items'].forEach((v) {
        items.add(new Meeting.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }
}
