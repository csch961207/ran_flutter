import 'package:flutter/material.dart';
import 'package:ran_flutter_message/model/message_content_model.dart';
import 'package:ran_flutter_message/model/message_content_provider_model.dart';
import 'package:ran_flutter_message/model/message_layout_provider_model.dart';
import 'package:ran_flutter_message/model/message_lists_model.dart';
import 'package:ran_flutter_message/model/message_lists_provider_model.dart';
import 'package:ran_flutter_message/widgets/extra_item.dart';
import 'package:ran_flutter_message/widgets/extra_items.dart';
import 'package:ran_flutter_message/widgets/message_content/message_content_types.dart';
import 'package:ran_flutter_message/widgets/message_list_types.dart';

// 消息类型，消息内容类型，消息列表类型，消息列表内容类型
// 底部聊天功能面板扩展，底部聊天工具栏扩展，
class MessageProvider {
  static void init() {
    addMessageContentProviderModel(MessageContentTypes.allMessageContentTypes);
    addMessageListsProviderModel(MessageListTypes.allMessageListTypes);
    addExtraItems(ExtraItems.allExtraItems);
  }

  //  扩展编辑消息类型
  static List<ExtraItemContainer> extraItems = [];

  static void addExtraItems(List<ExtraItemContainer> allExtraItems) {
    extraItems.addAll(allExtraItems);
  }

  static void addExtraItem(ExtraItemContainer extraItem, {int index}) {
    extraItems.insert(index, extraItem);
  }

  //  消息列表类型
  static List<MessageListsProviderModel> messageListTypes = [];

  static void addMessageListsProviderModel(
      List<MessageListsProviderModel> messageListsProviders) {
    messageListTypes.insertAll(0, messageListsProviders);
  }

//  获取消息列表组件
  static Widget getMessageListsProviderWidget(MessageLists messageLists) {
    MessageListsProviderModel findMessageLists = messageListTypes.firstWhere(
        (item) => item.messagesTypeName == messageLists.messagesTypeName,
        orElse: () => new MessageListsProviderModel());
    if (findMessageLists.messagesTypeWidget == null) {
      return Text(
        '该消息类型内容无法解析',
        style: TextStyle(color: Colors.red),
      );
    }
    return findMessageLists.messagesTypeWidget(messageLists);
  }

//  //  消息布局类型
//  static List<MessageLayoutProviderModel> messageLayoutTypes = [];
//
//  static void addMessageLayoutProviderModel(
//      List<MessageLayoutProviderModel> messageLayoutProviders) {
//    messageLayoutTypes.insertAll(0, messageLayoutProviders);
//  }
//
////  获取消息布局类型组件
//  static Widget getMessageLayoutProviderWidget(
//      MessageContentModel messageContent) {
//    MessageContentProviderModel findMessageContent = messageContents.firstWhere(
//            (item) => item.contentTypeName == messageContent.contentTypeName,
//        orElse: () => new MessageContentProviderModel());
//    if (findMessageContent.contentTypeWidget == null) {
//      return Text(
//        '未找到该组件',
//        style: TextStyle(color: Colors.red),
//      );
//    }
//    return findMessageContent.contentTypeWidget(messageContent);
//  }

  //  消息内容类型
  static List<MessageContentProviderModel> messageContents = [];

  static void addMessageContentProviderModel(
      List<MessageContentProviderModel> messageContentProviders) {
    messageContents.insertAll(0, messageContentProviders);
  }

//  获取消息内容组件
  static Widget getMessageContentProviderWidget(
      MessageContentModel messageContent, int styleType) {
    MessageContentProviderModel findMessageContent = messageContents.firstWhere(
        (item) => item.contentTypeName == messageContent.contentTypeName,
        orElse: () => new MessageContentProviderModel());
    if (findMessageContent.contentTypeWidget == null) {
      return Text(
        '该消息类型内容无法解析',
        style: TextStyle(color: Colors.red),
      );
    }
    return findMessageContent.contentTypeWidget(messageContent, styleType);
  }

//  获取消息列表内容组件
  static Widget getMessageListContentProviderWidget(
      MessageContentModel messageContent) {
    MessageContentProviderModel findMessageContent = messageContents.firstWhere(
        (item) => item.contentTypeName == messageContent.contentTypeName,
        orElse: () => new MessageContentProviderModel());
    if (findMessageContent.contentTypeListWidget == null) {
      return Text(
        '该消息类型内容无法解析',
        style: TextStyle(color: Colors.red),
      );
    }
    return findMessageContent.contentTypeListWidget(messageContent);
  }
}
