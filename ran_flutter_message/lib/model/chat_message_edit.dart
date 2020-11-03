class ChatMessageEdit {
  String messageId;
  String receiverId;
  int receiverType;
  String content;
  String sendTime;

  ChatMessageEdit(
      {this.messageId,
        this.receiverId,
        this.receiverType,
        this.content,
        this.sendTime});

  ChatMessageEdit.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    receiverId = json['receiverId'];
    receiverType = json['receiverType'];
    content = json['content'];
    sendTime = json['sendTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['receiverId'] = this.receiverId;
    data['receiverType'] = this.receiverType;
    data['content'] = this.content;
    data['sendTime'] = this.sendTime;
    return data;
  }
}
