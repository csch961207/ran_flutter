import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/page/chat_page.dart';
import 'package:ran_flutter_message/page/message_msg_page.dart';
import 'package:ran_flutter_message/page/user_page.dart';

class MessageRouter implements IRouterProvider {
  static String messages = "/messages";
  static String chat = "/messages/chat";
  static String user = "/messages/user";

  @override
  void initRouter(FluroRouter router) {
    router.define(messages,
        handler: Handler(handlerFunc: (_, params) => MessageMsgPage()));
    router.define(chat,
        handler: Handler(handlerFunc: (_, params) => ChatPage()));
    router.define(user,
        handler: Handler(handlerFunc: (_, params){
          String userStr = params['user']?.first;
          try{
            var json = jsonDecode(userStr);
            var model = CurrentUser.fromJson(json);
            return UserPage(currentUser: model);
          }catch(e){
            print(e);
            return UserPage();
          }
        } ));
  }
}
