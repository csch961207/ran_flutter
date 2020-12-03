import 'package:dio/dio.dart';
import 'package:ran_flutter_message/message_api.dart';
import 'package:ran_flutter_message/model/chat_message.dart';
import 'package:ran_flutter_message/model/chat_message_model.dart';
import 'package:ran_flutter_message/model/message.dart';
import 'package:ran_flutter_message/model/message_app.dart';
import 'package:ran_flutter_message/model/message_content_type_model.dart';
import 'package:ran_flutter_message/model/un_read_message_app_message.dart';
import 'package:ran_flutter_message/widgets/group/message_list_group_model.dart';
import 'package:ran_flutter_message/widgets/message_app/message_list_message_app_model.dart';
import 'package:ran_flutter_message/widgets/user/messages_user_model.dart';

class MessageRepository {
  /// 获取消息类型字段
  static Future fetchMessageContentTypes() async {
    var response = await messageHttp.get('/api/messages/contentType');
    return response.data
        .map<MessageContentType>((item) => MessageContentType.fromJson(item))
        .toList();
  }

  /// 获取通知应用
  static Future fetchMessageApps() async {
    var response =
        await messageHttp.get('/api/messages/MessageApp/GetMessageApps');
    return MessagesApp.fromJson(response.data);
  }

  /// 获取未读用户消息列表
  static Future fetchUnReadChatMessagesByUser() async {
    var response =
        await messageHttp.get('/api/messages/chat/GetUnreadChatMessagesByUser');
    return MessagesUser.fromJson(response.data);
  }

  /// 获取未读群组消息列表
  static Future fetchUnReadChatMessagesByGroup() async {
    var response = await messageHttp
        .get('/api/messages/chat/getUnreadChatMessagesByGroup');
    return MessagesGroup.fromJson(response.data);
  }

  /// 获取用户消息页列表
  static Future fetchChatMessagesByUser(int pageNum, String senderId) async {
    Map<String, String> params = Map();
    params["chatObjectId"] = senderId;
    params["receiverType"] = '0';
    params["maxResultCount"] = '30';
    params["skipCount"] = (pageNum * 30).toString();
    var response = await messageHttp.get(
        '/api/messages/chat/GetChatMessagesByUser',
        queryParameters: params);
    return ChatMessages.fromJson(response.data);
  }

  /// 获取群组消息页列表
  static Future fetchChatMessagesByGroup(int pageNum, String receiverId) async {
    Map<String, String> params = Map();
    params["chatObjectId"] = receiverId;
    params["receiverType"] = '1';
    params["maxResultCount"] = '30';
    params["skipCount"] = (pageNum * 30).toString();
    var response = await messageHttp.get(
        '/api/messages/chat/GetChatMessagesByGroup',
        queryParameters: params);
    return ChatMessages.fromJson(response.data);
  }

  /// 获取未读通知列表
  static Future fetchUnreadMessageAppMessages() async {
    var response =
        await messageHttp.get('/api/messages/MessageApp/GetUnreadMessages');
    return MessagesApp.fromJson(response.data);
  }

  /// 获取通知页列表
  static Future fetchMessageAppMessage(String messageAppName) async {
    Map<String, String> params = Map();
    params["messageAppName"] = messageAppName;
    var response = await messageHttp.get('/api/messages/MessageApp/GetMessages',
        queryParameters: params);
    return response.data['items']
        .map<UnReadMessageAppMessage>(
            (item) => UnReadMessageAppMessage.fromJson(item))
        .toList();
  }

  ///设置为已读
  static Future saveLastReceiveTime(String sendId, {String receiveId}) async {
    Map<String, String> params = Map();
    params["sendId"] = sendId;
    if (receiveId != null) {
      params["receiveId"] = receiveId;
    }
    var response = await messageHttp.post(
        '/api/messages/chat/SaveLastReceiveTime',
        queryParameters: params);
    return response.statusCode;
  }

  ///删除列表消息
  static Future receivingStatus(String sendId) async {
    Map<String, String> params = Map();
    params["sendId"] = sendId;
    params["type"] = '1';
    var response = await messageHttp.put('/api/messages/chat/ReceivingStatus',
        queryParameters: params);
    return response.statusCode;
  }
}
