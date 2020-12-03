import 'package:flutter/material.dart';
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

  List<MessageLists> _ltMsg = [];
  List<MessageLists> get ltMsg => _ltMsg;

  List<ChatMessageItem> _currentMessages = [];
  List<ChatMessageItem> get currentMessages => _currentMessages;
  String _currentGroupChatId = '';
  String get currentGroupChatId => _currentGroupChatId;
  String _currentUserChatId = '';
  String get currentUserChatId => _currentUserChatId;

  List<MessageContentType> _contentTypes = [];
  List<MessageContentType> get contentTypes => _contentTypes;
  List<MessagesAppItem> _messageApps = [];
  List<MessagesAppItem> get messageApps => _messageApps;

  List<UnReadMessageAppMessage> _currentMessageApps = [];
  List<UnReadMessageAppMessage> get currentMessageApps => _currentMessageApps;

//  MessagesUserItem.fromJson(widget.messageLists.messageList);
  MessagesUserItem currentMessageData;

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
      await hubConnection.stop();
      hubConnection.onclose((error) =>
          currentUserChatId != '' || _currentGroupChatId != ''
              ? onDone()
              : print('重连失败'));
      await hubConnection.start().then((value) {
        _conState = 1;
        frequency = 0;
        print('连接成功');
      }).catchError((onError) {
        _conState = 0;
      });
      hubConnection.keepAliveIntervalInMilliseconds = 15000;
      hubConnection.serverTimeoutInMilliseconds = 30000;
      hubConnection.on("ReceiveMessage", (e) => receiveMessage(e.first));
      hubConnection.on("PushMessage", (e) => pushMessage(e.first));
    } catch (e) {
      _conState = 0;
      print('连接失败');
      onError(e);
    }
  }

  MessageModel() {
    init();
  }

  init() async {
    _loading = true;
    notifyListeners();
    try {
      MessagesApp messagesApp = await MessageRepository.fetchMessageApps();
      _messageApps = messagesApp.items;
      _contentTypes = await MessageRepository.fetchMessageContentTypes();
      await _initSignalR();
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
      print('获取到消息');
      print(_ltMsg.length);
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      print(e);
      notifyListeners();
    }
  }

  setCurrentMessageData(Map<String, Object> currentMessageData) {
    this.currentMessageData = MessagesUserItem.fromJson(currentMessageData);
    notifyListeners();
  }

  /// 设置已读
  @override
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

  setRead(int index) {
//    if (_ltMsg[index].messageTypeName == MessageTypeName.User ||
//        _ltMsg[index].messageTypeName == MessageTypeName.Group) {
//      (_ltMsg[index] as UnReadChatMessages).entry.count = 0;
//    }
//    if (_ltMsg[index].messageTypeName == MessageTypeName.MessageApp) {
//      (_ltMsg[index] as UnReadMessageAppMessages).entry.count = 0;
//    }
    notifyListeners();
  }

  /// 删除消息列表
  Future<bool> receivingStatus(String sendId, int index) async {
    try {
      var response = await MessageRepository.receivingStatus(sendId);
      print('返回');
      print(response);
      if (response == 204 || response == 0 || response == 200) {
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

//    print('最后${arr.length.toString()}');
//    print(_currentMessageApps[0].content);

    return true;
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

//  设置当前聊天用户
  setCurrentUserChatId(String currentUserChatId) {
    _currentUserChatId = currentUserChatId;
    _currentGroupChatId = '';
    print('设置当前聊天用户:${_currentUserChatId}');
    notifyListeners();
  }

  //  设置当前聊天群组
  setCurrentGroupChatId(String currentGroupChatId) {
    _currentGroupChatId = currentGroupChatId;
    _currentUserChatId = '';
    notifyListeners();
  }

// 接受消息
  receiveMessage(e) {
    print('发送人：${e}');
    ChatMessage chatmessage = ChatMessage.fromJson(e);
    print('id：${chatmessage.id}');
    print('发送人：${chatmessage.senderName}');
    print('接受类型：${chatmessage.receiverType}');
    print('接收者：${chatmessage.receiverName}');
    print('接收者id：${chatmessage.receiverId}');
    print('发送者id：${chatmessage.senderId}');
    print('接收时间：${chatmessage.sendTime}');
    print('内容：${chatmessage.content}');
    print('内容：${chatmessage.content}');
    try {
//      User user;
//      var userMap = StorageManager.localStorage.getItem('kUser');
//      if (userMap != null) {
//        user = User.fromJsonMap(userMap);
//      }
      if (chatmessage.receiverType == 0) {
        print('当前聊天用户：${_currentUserChatId}');
//      自己发的
        if (chatmessage.senderId == 'user.id') {
          if (_currentMessages.length > 0 &&
              _currentMessages[0].id == chatmessage.id) {
            notifyListeners();
            return;
          }
        }
        if (chatmessage.senderId == _currentUserChatId) {
          print('当前聊天id：${_currentMessages[0].id}');
          print('收到的：${_currentMessages[0].id}');
          if (_currentMessages.length > 0 &&
              _currentMessages[0].id == chatmessage.id) {
            notifyListeners();
            return;
          }
//          _currentMessages.insert(0, chatmessage);
          notifyListeners();
        }
      }

      if (chatmessage.receiverType == 1) {
        try {
          if (chatmessage.receiverId == _currentGroupChatId) {
            if (_currentMessages.length > 0 &&
                _currentMessages[0].id == chatmessage.id) {
              notifyListeners();
              return;
            }
//            _currentMessages.insert(0, chatmessage);
            notifyListeners();
          }
        } catch (e) {
          ToastUtil.show(e.toString());
        }
      }

      if ('user' != null &&
          'user.id' == chatmessage.senderId &&
          chatmessage.receiverType == 0) {
//        _currentMessages.insert(0, chatmessage);
        notifyListeners();
        for (var i = 0; i < _ltMsg.length; i++) {
          if (_ltMsg[i].messagesTypeName != 'MessageApp' &&
              (_ltMsg[i] as UnReadChatMessages).entry.senderId ==
                  chatmessage.receiverId &&
              (_ltMsg[i] as UnReadChatMessages).entry.receiverType == 0) {
            if ((_ltMsg[i] as UnReadChatMessages).entry.id != chatmessage.id) {
              (_ltMsg[i] as UnReadChatMessages).entry.id = chatmessage.id;
              (_ltMsg[i] as UnReadChatMessages).entry.count =
                  (_ltMsg[i] as UnReadChatMessages).entry.count;
              (_ltMsg[i] as UnReadChatMessages).entry.content =
                  chatmessage.content;
              (_ltMsg[i] as UnReadChatMessages).entry.sendTime =
                  chatmessage.sendTime;
              (_ltMsg[i] as UnReadChatMessages).entry.senderId =
                  chatmessage.receiverId;
              (_ltMsg[i] as UnReadChatMessages).entry.receiverId =
                  chatmessage.senderId;
              (_ltMsg[i] as UnReadChatMessages).entry.receiverName =
                  chatmessage.senderName;
              (_ltMsg[i] as UnReadChatMessages).entry.senderName =
                  chatmessage.receiverName;
              (_ltMsg[i] as UnReadChatMessages).entry.receiverType =
                  chatmessage.receiverType;
              notifyListeners();
            }
            break;
          }
          notifyListeners();
          print('走这里');
        }
        return;
      }

      if (chatmessage.receiverType == 0) {
        for (var i = 0; i < _ltMsg.length; i++) {
          if (_ltMsg[i].messagesTypeName != 'MessageApp' &&
              (_ltMsg[i] as UnReadChatMessages).entry.senderId ==
                  chatmessage.senderId &&
              (_ltMsg[i] as UnReadChatMessages).entry.receiverType == 0) {
            if ((_ltMsg[i] as UnReadChatMessages).entry.id != chatmessage.id) {
              (_ltMsg[i] as UnReadChatMessages).entry.id = chatmessage.id;
              (_ltMsg[i] as UnReadChatMessages).entry.count =
                  (_ltMsg[i] as UnReadChatMessages).entry.count + 1;
              (_ltMsg[i] as UnReadChatMessages).entry.content =
                  chatmessage.content;
              (_ltMsg[i] as UnReadChatMessages).entry.sendTime =
                  chatmessage.sendTime;
              (_ltMsg[i] as UnReadChatMessages).entry.senderName =
                  chatmessage.senderName;
              (_ltMsg[i] as UnReadChatMessages).entry.senderId =
                  chatmessage.senderId;
              (_ltMsg[i] as UnReadChatMessages).entry.receiverId =
                  chatmessage.receiverId;
              (_ltMsg[i] as UnReadChatMessages).entry.receiverName =
                  chatmessage.receiverName;
              (_ltMsg[i] as UnReadChatMessages).entry.receiverType =
                  chatmessage.receiverType;
              notifyListeners();
            }
            break;
          } else if (i == _ltMsg.length - 1) {
            UnReadChatMessages unReadChatMessages = UnReadChatMessages();
            unReadChatMessages.messageTypeName = MessageTypeName.User;
            unReadChatMessages.entry = Message(
                id: chatmessage.id,
                senderId: chatmessage.senderId,
                senderName: chatmessage.senderName,
                receiverId: chatmessage.receiverId,
                receiverName: chatmessage.receiverName,
                count: 1,
                sendTime: chatmessage.sendTime,
                content: chatmessage.content,
                receiverType: chatmessage.receiverType);
//            _ltMsg.add(unReadChatMessages);
            notifyListeners();
            print('走0');
          }
        }
      }
      if (chatmessage.receiverType == 1) {
        for (var i = 0; i < _ltMsg.length; i++) {
          if (_ltMsg[i].messagesTypeName != 'MessageApp' &&
              (_ltMsg[i] as UnReadChatMessages).entry.receiverId ==
                  chatmessage.receiverId &&
              (_ltMsg[i] as UnReadChatMessages).entry.receiverType == 1) {
            if ((_ltMsg[i] as UnReadChatMessages).entry.id != chatmessage.id) {
              (_ltMsg[i] as UnReadChatMessages).entry.id = chatmessage.id;
              (_ltMsg[i] as UnReadChatMessages).entry.count =
                  (_ltMsg[i] as UnReadChatMessages).entry.count + 1;
              (_ltMsg[i] as UnReadChatMessages).entry.content =
                  chatmessage.content;
              (_ltMsg[i] as UnReadChatMessages).entry.sendTime =
                  chatmessage.sendTime;
              (_ltMsg[i] as UnReadChatMessages).entry.senderName =
                  chatmessage.senderName;
              (_ltMsg[i] as UnReadChatMessages).entry.senderId =
                  chatmessage.senderId;
              (_ltMsg[i] as UnReadChatMessages).entry.receiverId =
                  chatmessage.receiverId;
              (_ltMsg[i] as UnReadChatMessages).entry.receiverName =
                  chatmessage.receiverName;
              (_ltMsg[i] as UnReadChatMessages).entry.receiverType =
                  chatmessage.receiverType;
              notifyListeners();
            }
            break;
          } else if (i == _ltMsg.length - 1) {
            UnReadChatMessages unReadChatMessages = UnReadChatMessages();
            unReadChatMessages.messageTypeName = MessageTypeName.Group;
            unReadChatMessages.entry = Message(
                id: chatmessage.id,
                senderId: chatmessage.senderId,
                senderName: chatmessage.senderName,
                receiverId: chatmessage.receiverId,
                receiverName: chatmessage.receiverName,
                count: 1,
                sendTime: chatmessage.sendTime,
                content: chatmessage.content,
                receiverType: chatmessage.receiverType);
//            _ltMsg.add(unReadChatMessages);
            notifyListeners();
          }
        }
        print('走1');
        print(_ltMsg);
      }

      if (_ltMsg.length == 0) {
        UnReadChatMessages unReadChatMessages = UnReadChatMessages();
        if (chatmessage.receiverType == 0) {
          print('走0');
          unReadChatMessages.messageTypeName = MessageTypeName.User;
        }
        if (chatmessage.receiverType == 1) {
          print('走1');
          unReadChatMessages.messageTypeName = MessageTypeName.Group;
        }
        unReadChatMessages.entry = Message(
            id: chatmessage.id,
            senderId: chatmessage.senderId,
            senderName: chatmessage.senderName,
            receiverId: chatmessage.receiverId,
            receiverName: chatmessage.receiverName,
            count: 1,
            sendTime: chatmessage.sendTime,
            content: chatmessage.content,
            receiverType: chatmessage.receiverType);
//        _ltMsg.add(unReadChatMessages);
        notifyListeners();
      }
    } catch (e) {
      ToastUtil.show(e.toString());
    }
    debugPrint('接受：${Message.fromJson(e)}');
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
      debugPrint('发送错误');
      ToastUtil.show('发送失败');
    }
  }

  onError(error) {
    print('error------------>${error}');
  }

  void onDone() async {
//    var userMap = StorageManager.localStorage.getItem('kUser');
//    if (userMap != null) {
//      print('重连：${_conState}');
//      await hubConnection.stop();
//      print('断开了');
//      _initSignalR();
//      print('重连');
//    } else {
//      print(userMap);
//    }
    frequency++;
    if (frequency > 5) {
      return;
    }
    print('重连：${_conState}');
    await hubConnection.stop();
    print('断开了');
    _initSignalR();
    print('重连');
  }

  close() {
    print('关闭了');
    notifyListeners();
  }
}
