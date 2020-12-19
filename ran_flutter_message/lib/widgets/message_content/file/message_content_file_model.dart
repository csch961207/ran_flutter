class MessageContentFileModel {
  String contentTypeName;
  String fileId;
  String fileName;
  int fileSize;
  String assemblyNameAndTypeName;

  MessageContentFileModel(
      {this.contentTypeName,
      this.fileId,
      this.fileName,
      this.fileSize,
      this.assemblyNameAndTypeName});

  MessageContentFileModel.fromJson(Map<String, dynamic> json) {
    contentTypeName = json['contentTypeName'];
    fileId = json['fileId'];
    fileName = json['fileName'];
    fileSize = json['fileSize'];
    assemblyNameAndTypeName = json['assemblyNameAndTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentTypeName'] = this.contentTypeName;
    data['fileId'] = this.fileId;
    data['fileName'] = this.fileName;
    data['fileSize'] = this.fileSize;
    data['assemblyNameAndTypeName'] = this.assemblyNameAndTypeName;
    return data;
  }
}
