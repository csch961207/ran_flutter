class MessageContentType {
  String contentTypeName;
  String assemblyNameAndTypeName;

  MessageContentType({this.contentTypeName, this.assemblyNameAndTypeName});

  MessageContentType.fromJson(Map<String, dynamic> json) {
    contentTypeName = json['contentTypeName'];
    assemblyNameAndTypeName = json['assemblyNameAndTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentTypeName'] = this.contentTypeName;
    data['assemblyNameAndTypeName'] = this.assemblyNameAndTypeName;
    return data;
  }
}
