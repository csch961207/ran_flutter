
class MessagesUser {
  List<MessagesUserItem> items;

  MessagesUser({this.items});

  MessagesUser.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<MessagesUserItem>();
      json['items'].forEach((v) {
        items.add(new MessagesUserItem.fromJson(v));
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

class MessagesUserItem {
  String senderId;
  String senderName;
  String receiverId;
  String receiverName;
  int receiverType;
  Map<String, Object> content;
  String sendTime;
  int count;

  MessagesUserItem(
      {this.senderId,
      this.senderName,
      this.receiverId,
      this.receiverName,
      this.receiverType,
      this.content,
      this.sendTime,
      this.count});

  MessagesUserItem.fromJson(Map<String, dynamic> json) {
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
