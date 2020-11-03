import 'dart:convert' as convert;

class MessagesApp {
  List<MessagesAppItem> items;

  MessagesApp({this.items});

  MessagesApp.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<MessagesAppItem>();
      json['items'].forEach((v) {
        items.add(new MessagesAppItem.fromJson(v));
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

class MessagesAppItem {
  String name;
  String appName;
  String avatar;
  bool canBeChat;
  int count;
  String sendTime;
  Map<String, Object> content;

  MessagesAppItem(
      {this.name,
        this.appName,
        this.avatar,
        this.canBeChat,
        this.count,
        this.sendTime,
        this.content});

  MessagesAppItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    appName = json['appName'];
    avatar = json['avatar'];
    canBeChat = json['canBeChat'];
    count = json['count'];
    sendTime = json['sendTime'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['appName'] = this.appName;
    data['avatar'] = this.avatar;
    data['canBeChat'] = this.canBeChat;
    data['count'] = this.count;
    data['sendTime'] = this.sendTime;
    data['content'] = this.content;
    return data;
  }
}