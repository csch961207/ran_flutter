import 'dart:convert' as convert;

class Message {
  String id;
  String senderId;
  String senderName;
  String receiverId;
  String receiverName;
  int receiverType;
  String content;
  String sendTime;
  int count;

  Message(
      {this.id,
        this.senderId,
        this.senderName,
        this.receiverId,
        this.receiverName,
        this.receiverType,
        this.content,
        this.sendTime,
        this.count});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    receiverId = json['receiverId'];
    receiverName = json['receiverName'];
    receiverType = json['receiverType'];
    content = convert.jsonEncode(json['content']);
    count = json['count'];
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
    data['count'] = this.count;
    return data;
  }
}

class MessageContent {
  ContentTypeName contentTypeName;
  String assemblyNameAndTypeName;

  MessageContent({this.contentTypeName, this.assemblyNameAndTypeName});

  Map toJson() {
    return {
      'contentTypeName': contentTypeName.toString(),
      'assemblyNameAndTypeName': assemblyNameAndTypeName.toString()
    };
  }

  MessageContent.fromJson(Map<String, dynamic> json) {
    contentTypeName =
        getEnumFromString(ContentTypeName.values, json['contentTypeName']);
    assemblyNameAndTypeName = json['assemblyNameAndTypeName'];
  }

  static dynamic generateMessageFromJson(Map<dynamic, dynamic> json) {
    if (json == null) {
      return null;
    }

    ContentTypeName type =
    getEnumFromString(ContentTypeName.values, json['contentTypeName']);
    switch (type) {
      case ContentTypeName.Text:
        return TextType.fromJson(json);
        break;
      case ContentTypeName.Attendance:
        return TextType.fromJson(json);
        break;
      case ContentTypeName.Picture:
        return PictureType.fromJson(json);
        break;
      case ContentTypeName.File:
        return FileType.fromJson(json);
        break;
      case ContentTypeName.ChooseToLearn:
        return ChooseToLearnType.fromJson(json);
        break;
      case ContentTypeName.MustLearn:
        return MustLearnType.fromJson(json);
        break;
    }
  }
}

//enum ContentTypeName { Text, Picture, File, Reply, ChooseToLearn, MustLearn, Attendance }
enum ContentTypeName {
  Text,
  Picture,
  File,
  ChooseToLearn,
  MustLearn,
  Attendance
}

class TextType extends MessageContent {
  String content;

  TextType({this.content});

  Map toJson() {
    var json = super.toJson();
    json['content'] = content;
    return json;
  }

  TextType.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        super.fromJson(json);
}

class PictureType extends MessageContent {
  String webUrl;

  PictureType({this.webUrl});

  Map toJson() {
    var json = super.toJson();
    json['webUrl'] = webUrl;
    return json;
  }

  PictureType.fromJson(Map<String, dynamic> json)
      : webUrl = json['webUrl'],
        super.fromJson(json);
}

class FileType extends MessageContent {
  String fileId;
  String fileName;
  int fileSize;

  FileType({this.fileId, this.fileName, this.fileSize});

  Map toJson() {
    var json = super.toJson();
    json['fileId'] = fileId;
    json['fileName'] = fileName;
    json['fileSize'] = fileSize;
    return json;
  }

  FileType.fromJson(Map<String, dynamic> json)
      : fileId = json['fileId'],
        fileName = json['fileName'],
        fileSize = json['fileSize'],
        super.fromJson(json);
}

class ChooseToLearnType extends MessageContent {
  String content;

  ChooseToLearnType({this.content});

  Map toJson() {
    var json = super.toJson();
    json['content'] = content;
    return json;
  }

  ChooseToLearnType.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        super.fromJson(json);
}

class MustLearnType extends MessageContent {
  String content;

  MustLearnType({this.content});

  Map toJson() {
    var json = super.toJson();
    json['content'] = content;
    return json;
  }

  MustLearnType.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        super.fromJson(json);
}

T getEnumFromString<T>(Iterable<T> values, String str) {
  return values.firstWhere((f) => f.toString().split('.').last == str,
      orElse: () => null);
}

String getStringFromEnum<T>(T) {
  if (T == null) {
    return null;
  }
  return T.toString().split('.').last;
}