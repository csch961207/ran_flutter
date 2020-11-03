import 'dart:convert' as convert;
class MessageAppMessage {
  String appName;
  String avatar;
  String sendTime;
  String content;

  MessageAppMessage(
      {this.appName,
        this.avatar,
        this.sendTime,
        this.content});

  MessageAppMessage.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    avatar = json['avatar'];
    sendTime = json['sendTime'];
    content = convert.jsonEncode(json['content']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appName'] = this.appName;
    data['avatar'] = this.avatar;
    data['sendTime'] = this.sendTime;
    data['content'] = this.content;
    return data;
  }
}