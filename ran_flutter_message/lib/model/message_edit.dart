class MessageEdit {
  String messageId;
  String receiverId;
  String receiverName;
  int receiverType;
  String content;
  String sendTime;

  MessageEdit(
      {this.messageId,
        this.receiverId,
        this.receiverName,
        this.receiverType,
        this.content,
        this.sendTime});

  MessageEdit.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    receiverId = json['receiverId'];
    receiverName = json['receiverName'];
    receiverType = json['receiverType'];
    content = json['content'];
    sendTime = json['sendTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['receiverId'] = this.receiverId;
    data['receiverName'] = this.receiverName;
    data['receiverType'] = this.receiverType;
    data['content'] = this.content;
    data['sendTime'] = this.sendTime;
    return data;
  }
}