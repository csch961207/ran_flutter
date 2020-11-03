import 'dart:convert' as convert;

class MessagesGroup {
  List<MessagesGroupItem> items;

  MessagesGroup({this.items});

  MessagesGroup.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<MessagesGroupItem>();
      json['items'].forEach((v) {
        items.add(new MessagesGroupItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessagesGroupItem {
  String senderId;
  String senderName;
  String receiverId;
  String receiverName;
  int receiverType;
  Map<String, Object> content;
  String sendTime;
  int count;

  MessagesGroupItem(
      {this.senderId,
        this.senderName,
        this.receiverId,
        this.receiverName,
        this.receiverType,
        this.content,
        this.sendTime,
        this.count});

  MessagesGroupItem.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    senderName = json['senderName'];
    receiverId = json['receiverId'];
    receiverName = json['receiverName'];
    receiverType = json['receiverType'];
    content = json['content'];
    sendTime = json['sendTime'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['senderName'] = this.senderName;
    data['receiverId'] = this.receiverId;
    data['receiverName'] = this.receiverName;
    data['receiverType'] = this.receiverType;
    data['content'] = this.content;
    data['sendTime'] = this.sendTime;
    data['count'] = this.count;
    return data;
  }
}