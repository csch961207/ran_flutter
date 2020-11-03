
import 'package:ran_flutter_message/model/message.dart';
import 'package:ran_flutter_message/model/un_read_message_app_message.dart';

class AllMessage {
  MessageTypeName messageTypeName;

  AllMessage({this.messageTypeName});

  Map toJson() {
    return {'messageTypeName': messageTypeName};
  }

  AllMessage.fromJson(Map<String, dynamic> json) {
    messageTypeName = json['messageTypeName'];
  }

  static dynamic generateAllMessageFromJson(Map<dynamic, dynamic> json) {
    if (json == null) {
      return null;
    }

    MessageTypeName type =
    getEnumFromString(MessageTypeName.values, json['messageTypeName']);
    switch (type) {
      case MessageTypeName.User:
        return UnReadChatMessages.fromJson(json);
        break;
      case MessageTypeName.Group:
        return UnReadChatMessages.fromJson(json);
        break;
      case MessageTypeName.MessageApp:
        return FileType.fromJson(json);
        break;
    }
  }
}

enum MessageTypeName { User, Group, MessageApp }

class UnReadChatMessages extends AllMessage {
  Message entry;

  UnReadChatMessages({this.entry});

  Map toJson() {
    var json = super.toJson();
    json['entry'] = entry;
    return json;
  }

  UnReadChatMessages.fromJson(Map<String, dynamic> json)
      : entry = json['entry'],
        super.fromJson(json);
}

class UnReadMessageAppMessages extends AllMessage {
  UnReadMessageAppMessage entry;

  UnReadMessageAppMessages({this.entry});

  Map toJson() {
    var json = super.toJson();
    json['entry'] = entry;
    return json;
  }

  UnReadMessageAppMessages.fromJson(Map<String, dynamic> json)
      : entry = json['entry'],
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