class MessageLists {
  String messagesTypeName;
  Map<String, Object> messageList;
  MessageLists({this.messagesTypeName, this.messageList});

  MessageLists.fromJson(Map<String, dynamic> json) {
    messagesTypeName = json['messagesTypeName'];
    messageList = json['messageList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messagesTypeName'] = this.messagesTypeName;
    data['messageList'] = this.messageList;
    return data;
  }
}
