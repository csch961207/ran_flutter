import 'dart:convert' as convert;
class UnReadMessageAppMessage {
  String appName;
  String name;
  String avatar;
  bool canBeChat;
  int count;
  String sendTime;
  String content;

  UnReadMessageAppMessage(
      {this.appName,
        this.name,
        this.avatar,
        this.canBeChat,
        this.count,
        this.sendTime,
        this.content});

  UnReadMessageAppMessage.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    name = json['name'];
    avatar = json['avatar'];
    canBeChat = json['canBeChat'];
    count = json['count'];
    sendTime = json['sendTime'];
    content = convert.jsonEncode(json['content']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appName'] = this.appName;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['canBeChat'] = this.canBeChat;
    data['count'] = this.count;
    data['sendTime'] = this.sendTime;
    data['content'] = this.content;
    return data;
  }
}