class ChatMessages {
  int totalCount;
  List<ChatMessageItem> items;

  ChatMessages({this.totalCount, this.items});

  ChatMessages.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = new List<ChatMessageItem>();
      json['items'].forEach((v) {
        items.add(new ChatMessageItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatMessageItem {
  String id;
  String senderId;
  String senderName;
  String receiverId;
  String receiverName;
  int receiverType;
  Map<String, Object> content;
  String sendTime;

  ChatMessageItem(
      {this.id,
      this.senderId,
      this.senderName,
      this.receiverId,
      this.receiverName,
      this.receiverType,
      this.content,
      this.sendTime});

  ChatMessageItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    receiverId = json['receiverId'];
    receiverName = json['receiverName'];
    receiverType = json['receiverType'];
    content = json['content'];
    sendTime = json['sendTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['senderId'] = this.senderId;
    data['senderName'] = this.senderName;
    data['receiverId'] = this.receiverId;
    data['receiverName'] = this.receiverName;
    data['receiverType'] = this.receiverType;
    data['content'] = this.content;
    data['sendTime'] = this.sendTime;
    return data;
  }
}
