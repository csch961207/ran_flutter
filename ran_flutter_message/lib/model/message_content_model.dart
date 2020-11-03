class MessageContentModel {
  String contentTypeName;
  Map<String, Object> content;
  MessageContentModel({this.contentTypeName, this.content});

  MessageContentModel.fromJson(Map<String, dynamic> json) {
    contentTypeName = json['contentTypeName'];
    content = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentTypeName'] = this.contentTypeName;
    data['content'] = this.content;
    return data;
  }
}
