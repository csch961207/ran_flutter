import 'package:flutter/material.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/message_repository.dart';
import 'package:ran_flutter_message/model/all_Message.dart';
import 'package:ran_flutter_message/model/chat_message.dart';
import 'package:ran_flutter_message/model/chat_message_edit.dart';
import 'package:ran_flutter_message/model/chat_message_model.dart';
import 'package:ran_flutter_message/model/message.dart';
import 'package:ran_flutter_message/model/message_app.dart';
import 'package:ran_flutter_message/model/message_content_type_model.dart';
import 'package:ran_flutter_message/model/message_lists_model.dart';
import 'package:ran_flutter_message/model/un_read_message_app_message.dart';
import 'package:ran_flutter_message/widgets/message_app/message_list_message_app_model.dart';
import 'package:ran_flutter_message/widgets/user/messages_user_model.dart';
import 'package:signalr_client/signalr_client.dart';
import 'package:flutter/foundation.dart';

class MessageModel with ChangeNotifier {
  int _conState = 0;
  bool _loading = false;
  bool get loading => _loading;
  int frequency = 0;

  int _unreadCount = 0;
  int get unreadCount => _unreadCount;

  List<MessageLists> _ltMsg = [];
  List<MessageLists> get ltMsg => _ltMsg;

  List<ChatMessageItem> _currentMessages = [];
  List<ChatMessageItem> get currentMessages => _currentMessages;
  String _currentChatId = '';
  String get currentChatId => _currentChatId;

  List<MessageContentType> _contentTypes = [];
  List<MessageContentType> get contentTypes => _contentTypes;
  List<MessagesAppItem> _messageApps = [];
  List<MessagesAppItem> get messageApps => _messageApps;

  List<UnReadMessageAppMessage> _currentMessageApps = [];
  List<UnReadMessageAppMessage> get currentMessageApps => _currentMessageApps;

//  MessagesUserItem.fromJson(widget.messageLists.messageList);
  MessagesUserItem currentMessageData;

  List<MessageLists> _defaultLtMsg = [];
  List<MessageLists> get defaultLtMsg => _defaultLtMsg;

  void setBusy() {
    _loading = true;
    notifyListeners();
  }

  void setSuccessed() {
    _loading = false;
    notifyListeners();
  }

  // SignalR地址
  static final serverUrl =
      ConfigService.getApiUrl(key: "RanMessage") + "/chathub";

  /// 获取token
  static Future<String> Function() accessToken = () {
    return new Future(
        () => StorageManager.sharedPreferences.getString("accessToken"));
  };

//  static final SignalRHttpClient client;

  static HttpConnectionOptions options = HttpConnectionOptions(
    accessTokenFactory: accessToken,
//      httpClient: client
  );
// SignalR Connection
  final hubConnection =
      HubConnectionBuilder().withUrl(serverUrl, options: options).build();

//初始化连接
  _initSignalR() async {
    print("Begin Connection");
    print(StorageManager.sharedPreferences.getString("accessToken"));
    try {
//      await hubConnection.stop();
      hubConnection.onclose((error) => print('关闭了'));
      await hubConnection.start().then((value) {
        _conState = 1;
        print('连接成功');
      }).catchError((onError) {
        print(onError);
        onDone();
      });
      hubConnection.keepAliveIntervalInMilliseconds = 15000;
      hubConnection.serverTimeoutInMilliseconds = 30000;
      hubConnection.on("ReceiveMessage", (e) => receiveMessage(e.first));
      hubConnection.on("PushMessage", (e) => pushMessage(e.first));
    } catch (e) {
      print('连接失败');
      onError(e);
    }
  }

  MessageModel(Map<String, dynamic> messageLists) {
    addMessagesUserList(messageLists);
    _initSignalR();
    init();
  }

  init() async {
    _loading = true;
    notifyListeners();
    try {
      MessagesApp messagesApp = await MessageRepository.fetchMessageApps();
      _messageApps = messagesApp.items;
      _contentTypes = await MessageRepository.fetchMessageContentTypes();
      // 获取所有消息列表
      List<Future> futures = [];
      futures.add(MessageRepository.fetchUnReadChatMessagesByUser());
      futures.add(MessageRepository.fetchUnReadChatMessagesByGroup());
      futures.add(MessageRepository.fetchUnreadMessageAppMessages());
      var result = await Future.wait(futures);
      _ltMsg = [];
      List<MessageLists> unReadChatMessagesByUser = result[0]
          .items
          .map<MessageLists>((messagesUser) => MessageLists.fromJson({
                'messagesTypeName': 'User',
                'messageList': messagesUser.toJson()
              }))
          .toList();
      _ltMsg.addAll(unReadChatMessagesByUser);
      List<MessageLists> unReadChatMessagesByGroup = result[1]
          .items
          .map<MessageLists>((messagesGroup) => MessageLists.fromJson({
                'messagesTypeName': 'Group',
                'messageList': messagesGroup.toJson()
              }))
          .toList();
      _ltMsg.addAll(unReadChatMessagesByGroup);
      List<MessageLists> unreadMessageAppMessages = result[2]
          .items
          .map<MessageLists>((messagesApp) => MessageLists.fromJson({
                'messagesTypeName': 'MessageApp',
                'messageList': messagesApp.toJson()
              }))
          .toList();
      _ltMsg.addAll(unreadMessageAppMessages);
      _unreadCount = 0;
      _ltMsg.forEach((item) {
        _unreadCount += item.messageList['count'];
      });
      if (_ltMsg.isEmpty) {
        _ltMsg.addAll(_defaultLtMsg);
      }
      for (var i = 0; i < _defaultLtMsg.length; i++) {
        int findIndex = _ltMsg.indexWhere((item) =>
            item.messageList['senderId'] ==
            _defaultLtMsg[i].messageList['senderId']);
        if (findIndex == -1) {
          _ltMsg.add(_defaultLtMsg[i]);
        }
      }
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      print('获取数据出错');
      print(e);
      notifyListeners();
    }
  }

  addMessagesUserList(Map<String, dynamic> messageLists) {
    List<MessageLists> unReadChatMessagesByUser = messageLists['items']
        .map<MessageLists>((messagesUser) => MessageLists.fromJson(
            {'messagesTypeName': 'User', 'messageList': messagesUser}))
        .toList();
    _defaultLtMsg.addAll(unReadChatMessagesByUser);
  }

  clearData() {
    _ltMsg.clear();
  }

  setCurrentMessageData(Map<String, Object> currentMessageData) {
    this.currentMessageData = MessagesUserItem.fromJson(currentMessageData);
    notifyListeners();
  }

  /// 设置最后阅读时间
  Future<bool> saveLastReceiveTime(String sendId, {String receiveId}) async {
    try {
      var response = await MessageRepository.saveLastReceiveTime(sendId,
          receiveId: receiveId);
      print('返回');
      print(response);
      if (response == 204 || response == 0 || response == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }

  /// 删除消息列表
  Future<bool> receivingStatus(String sendId, int index) async {
    try {
      var response = await MessageRepository.receivingStatus(sendId);
      print('返回');
      print(response);
      if (response == 204 || response == 0 || response == 200) {
        _unreadCount -= _ltMsg[index].messageList['count'];
        _ltMsg.removeAt(index);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }

//获取用户消息页列表
  Future chatMessagesByUser(int pageNum, String senderId) async {
    _loading = true;
    notifyListeners();
    if (pageNum == 0) {
      _currentMessages = [];
    }
    try {
      ChatMessages chatMessages =
          await MessageRepository.fetchChatMessagesByUser(pageNum, senderId);
      for (var i = chatMessages.items.length - 1; i > -1; i--) {
        _currentMessages.add(chatMessages.items[i]);
      }
      setCurrentChatId(senderId);
      _loading = false;
      notifyListeners();
    } catch (e) {
      ToastUtil.show(e.toString());
      _loading = false;
      notifyListeners();
      return true;
    }
  }

  //获取群组消息页列表
  Future chatMessagesByGroup(int pageNum, String receiverId) async {
    _loading = true;
    notifyListeners();
    if (pageNum == 0) {
      _currentMessages = [];
    }
    try {
      ChatMessages chatMessages =
          await MessageRepository.fetchChatMessagesByGroup(pageNum, receiverId);
      for (var i = chatMessages.items.length - 1; i > -1; i--) {
        _currentMessages.add(chatMessages.items[i]);
      }
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      ToastUtil.show(e.toString());
      print(e);
      _loading = false;
      notifyListeners();
      return true;
    }
  }

  //获取应用通知页列表
  Future messageAppMessages(String messageAppName) async {
    _loading = true;
    notifyListeners();
    try {
      List<UnReadMessageAppMessage> arr =
          await MessageRepository.fetchMessageAppMessage(messageAppName);
      _currentMessageApps = [];
      for (var i = arr.length - 1; i > -1; i--) {
        _currentMessageApps.add(arr[i]);
      }
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      ToastUtil.show(e.toString());
      return true;
    }
  }

  // 返回消息字段
  MessageContentType getMessageContentType(String contentTypeName) {
    print('数组：${_contentTypes}');
    print('传值：${contentTypeName}');
    MessageContentType result = _contentTypes.firstWhere(
        (item) =>
            item.contentTypeName.toLowerCase() == contentTypeName.toLowerCase(),
        orElse: () {
      return new MessageContentType();
    });
    if (result.contentTypeName == null) {
      ToastUtil.show('未查询到contentTypeName为【${contentTypeName}】ContentType');
    }
    return result;
  }

//  设置当前聊天id
  setCurrentChatId(String chatId) {
    _currentChatId = chatId;
    print('设置当前聊天用户:${_currentChatId}');
    notifyListeners();
  }

  setRead(int index) {
    _unreadCount -= _ltMsg[index].messageList['count'];
    _ltMsg[index].messageList['count'] = 0;
    notifyListeners();
  }

// 接受消息
  receiveMessage(e) async {
    print('发送人：${e}');
    ChatMessageItem chatMessageItem = ChatMessageItem.fromJson(e);
    String userId = StorageManager.sharedPreferences.getString("userId");
    if (chatMessageItem.senderId == userId) {
      if (_currentMessages.length == 0 ||
          _currentMessages[0].id != chatMessageItem.id) {
        _currentMessages.insert(0, chatMessageItem);
      }
    } else if (chatMessageItem.senderId == _currentChatId) {
      if (_currentMessages.length == 0 ||
          _currentMessages[0].id != chatMessageItem.id) {
        _currentMessages.insert(0, chatMessageItem);
      }
    } else if (chatMessageItem.receiverId == _currentChatId) {
      if (_currentMessages.length == 0 ||
          _currentMessages[0].id != chatMessageItem.id) {
        _currentMessages.insert(0, chatMessageItem);
      }
    }
    ChatMessageItem messageItem = ChatMessageItem.fromJson(e);
    if (messageItem.receiverType == 0) {
      bool isOneself = false;
      if (messageItem.senderId == userId) {
        isOneself = true;
        var exchange = messageItem.senderId;
        messageItem.senderId = messageItem.receiverId;
        messageItem.receiverId = exchange;
        exchange = messageItem.senderName;
        messageItem.senderName = messageItem.receiverName;
        messageItem.receiverName = exchange;
      }
      int findIndex = _ltMsg.indexWhere(
          (item) => item.messageList["senderId"] == messageItem.senderId);
      if (findIndex == -1) {
        _ltMsg.insert(
            0,
            MessageLists.fromJson({
              'messagesTypeName': 'User',
              'messageList': messageItem.toJson()
            }));
        _ltMsg[0].messageList['count'] = 1;
        if (!isOneself) {
          _unreadCount++;
        } else {
          setRead(0);
        }
      } else {
        print(_ltMsg[findIndex].messageList["id"] != messageItem.id);
        if (_ltMsg[findIndex].messageList["id"] != messageItem.id) {
          int count = _ltMsg[findIndex].messageList['count'];
          _ltMsg.removeAt(findIndex);
          _ltMsg.insert(
              0,
              MessageLists.fromJson({
                'messagesTypeName': 'User',
                'messageList': messageItem.toJson()
              }));
          _ltMsg[0].messageList['count'] = count + 1;
          if (!isOneself) {
            _unreadCount++;
          } else {
            setRead(0);
          }
        }
      }
    }
    notifyListeners();
  }

  /// 接收应用通知
  pushMessage(e) {
    UnReadMessageAppMessage unReadMessageAppMessage =
        UnReadMessageAppMessage.fromJson(e);
    print('通知应用：${unReadMessageAppMessage.appName}');
    print('接收时间：${unReadMessageAppMessage.sendTime}');
    print('内容：${unReadMessageAppMessage.content}');
    for (var i = 0; i < _ltMsg.length; i++) {
      if (_ltMsg[i].messagesTypeName == 'MessageApp' &&
          (_ltMsg[i] as UnReadMessageAppMessages).entry.name ==
              unReadMessageAppMessage.name) {
        (_ltMsg[i] as UnReadMessageAppMessages).entry.count =
            (_ltMsg[i] as UnReadMessageAppMessages).entry.count + 1;
        (_ltMsg[i] as UnReadMessageAppMessages).entry.content =
            unReadMessageAppMessage.content;
        (_ltMsg[i] as UnReadMessageAppMessages).entry.sendTime =
            unReadMessageAppMessage.sendTime;
        (_ltMsg[i] as UnReadMessageAppMessages).entry.appName =
            unReadMessageAppMessage.appName;
        (_ltMsg[i] as UnReadMessageAppMessages).entry.avatar =
            unReadMessageAppMessage.avatar;
        notifyListeners();
        break;
      } else if (i == _ltMsg.length - 1) {
        UnReadMessageAppMessages unReadMessageAppMessages =
            UnReadMessageAppMessages();
        unReadMessageAppMessages.messageTypeName = MessageTypeName.MessageApp;
        unReadMessageAppMessages.entry = UnReadMessageAppMessage(
            appName: unReadMessageAppMessage.appName,
            name: unReadMessageAppMessage.name,
            avatar: unReadMessageAppMessage.avatar,
            count: 1,
            sendTime: unReadMessageAppMessage.sendTime,
            content: unReadMessageAppMessage.content);
//        _ltMsg.add(unReadMessageAppMessages);
        notifyListeners();
      }
    }
    if (_ltMsg.length == 0) {
      UnReadMessageAppMessages unReadMessageAppMessages =
          UnReadMessageAppMessages();
      unReadMessageAppMessages.messageTypeName = MessageTypeName.MessageApp;
      unReadMessageAppMessages.entry = UnReadMessageAppMessage(
          appName: unReadMessageAppMessage.appName,
          avatar: unReadMessageAppMessage.avatar,
          name: unReadMessageAppMessage.name,
          count: 1,
          sendTime: unReadMessageAppMessage.sendTime,
          content: unReadMessageAppMessage.content);
//      _ltMsg.add(unReadMessageAppMessages);
      notifyListeners();
    }
    debugPrint('接受：${UnReadMessageAppMessage.fromJson(e)}');
    notifyListeners();
  }

// 接受未读消息
  receiveUnreadMessage(e) {
    Message message = Message.fromJson(e);
//    _currentMessages.insert(0, chatmessage);
//    notifyListeners();
    debugPrint('接受：${message.toString()}');
  }

// 发送消息
  void sendMsg(ChatMessageEdit e) async {
    print('内容${e.content}');
    try {
      final result =
          await hubConnection.invoke("sendMessage", args: <Object>[e.toJson()]);
//      _currentMessages.insert(0, chatMessage);
      notifyListeners();
      debugPrint('发送返回：${result}');
    } catch (e) {
      onError(e);
      ToastUtil.show('发送失败');
      Future.delayed(Duration(seconds: 5), () async {
        print('重新发送');
        sendMsg(e);
      });
    }
  }

//发送群组消息
  void sendMessageToGroup(ChatMessageEdit e) async {
    print('内容${e.receiverId}');
    try {
      final result = await hubConnection
          .invoke("sendMessageToGroup", args: <Object>[e.toJson()]);
//      _currentMessages.insert(0, chatMessage);
      notifyListeners();
      debugPrint('发送返回：${result}');
    } catch (e) {
      onError(e);
      ToastUtil.show('发送失败');
    }
  }

  onError(error) {
    print('error------------>${error}');
    onDone();
  }

  void onDone() async {
    // 延时1s执行返回
    Future.delayed(Duration(seconds: 5), () async {
      print('重连：${_conState}');
      await hubConnection.stop();
      _initSignalR();
    });
  }

  close() {
    print('关闭了');
    notifyListeners();
  }
}
