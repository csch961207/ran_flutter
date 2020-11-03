import 'dart:convert' as convert;

class ChatMessage {
  String id;
  String senderId;
  String senderName;
  String receiverId;
  String receiverName;
  int receiverType;
  String content;
  String sendTime;
  bool isSuccessed;

  ChatMessage(
      {this.id,
        this.senderId,
        this.senderName,
        this.receiverId,
        this.receiverName,
        this.receiverType,
        this.content,
        this.sendTime,
        this.isSuccessed});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    receiverId = json['receiverId'];
    receiverName = json['receiverName'];
    receiverType = json['receiverType'];
    content = convert.jsonEncode(json['content']);
    sendTime = json['sendTime'];
    isSuccessed = json['isSuccessed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['receiverName'] = this.receiverName;
    data['receiverType'] = this.receiverType;
    data['content'] = this.content;
    data['sendTime'] = this.sendTime;
    data['senderName'] = this.senderName;
    data['isSuccessed'] = this.isSuccessed;
    return data;
  }
}