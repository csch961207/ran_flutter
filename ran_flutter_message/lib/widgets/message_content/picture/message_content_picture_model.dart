class MessageContentPictureModel {
  String contentTypeName;
  String webUrl;
  String assemblyNameAndTypeName;

  MessageContentPictureModel(
      {this.contentTypeName, this.webUrl, this.assemblyNameAndTypeName});

  MessageContentPictureModel.fromJson(Map<String, dynamic> json) {
    contentTypeName = json['contentTypeName'];
    webUrl = json['webUrl'];
    assemblyNameAndTypeName = json['assemblyNameAndTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentTypeName'] = this.contentTypeName;
    data['webUrl'] = this.webUrl;
    data['assemblyNameAndTypeName'] = this.assemblyNameAndTypeName;
    return data;
  }
}