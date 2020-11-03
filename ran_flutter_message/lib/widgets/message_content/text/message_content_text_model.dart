class MessageContentTextModel {
  String contentTypeName;
  String content;
  String assemblyNameAndTypeName;

  MessageContentTextModel(
      {this.contentTypeName, this.content, this.assemblyNameAndTypeName});

  MessageContentTextModel.fromJson(Map<String, dynamic> json) {
    contentTypeName = json['contentTypeName'];
    content = json['content'];
    assemblyNameAndTypeName = json['assemblyNameAndTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentTypeName'] = this.contentTypeName;
    data['content'] = this.content;
    data['assemblyNameAndTypeName'] = this.assemblyNameAndTypeName;
    return data;
  }
}
