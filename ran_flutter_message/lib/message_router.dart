import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/page/chat_page.dart';
import 'package:ran_flutter_message/page/message_msg_page.dart';

class MessageRouter implements IRouterProvider {
  static String messages = "/messages";
  static String chat = "/messages/chat";

  @override
  void initRouter(FluroRouter router) {
    router.define(messages,
        handler: Handler(handlerFunc: (_, params) => MessageMsgPage()));
    router.define(chat,
        handler: Handler(handlerFunc: (_, params) => ChatPage()));
  }
}
