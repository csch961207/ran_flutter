import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_model.dart';

class PartyMemberList {
  List<PartyMember> items;
  int totalCount;

  PartyMemberList({this.items, this.totalCount});

  PartyMemberList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<PartyMember>();
      json['items'].forEach((v) {
        items.add(new PartyMember.fromJson(v));
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