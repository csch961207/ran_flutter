import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:ran_flutter_message/ran_flutter_message.dart';
//import 'package:ran_flutter_message/view_model/message_model.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with WidgetsBindingObserver {
  static Future getMessageApps() async {
//    var response = await http.get('api/messages/MessageApp/GetMessageApps');
//    return response.data["items"];
//    HttpClient client = HttpClient();
//    client.badCertificateCallback = (X509Certificate cert, String host, int port){
//      return true;
//    };
//    var request = await client.getUrl(Uri.parse("https://192.168.0.103:44341/api/messages/MessageApp/GetMessageApps"));
//    var response = await request.close();
//    print(response.toString());
//    return response;
  }

  @override
  void initState() {
    super.initState();
//    getMessageApps();
//    MessageModel model = Provider.of<MessageModel>(context, listen: false);
////    model.init();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
//        Provider.of<MessageModel>(context, listen: false).onDone();
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        break;
      case AppLifecycleState.detached: //
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('消息'),backgroundColor: Colors.white,),
        body: Container(
          color: Colors.white,
//          child: MessageMsgPage(),
        ));
  }
}
//
//class _Body extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    var model = Provider.of<MessageModel>(context, listen: false).ltMsg.length;
//
//    return Container(
//        height: 1140,
//        child: ListView.builder(
//          itemBuilder: (BuildContext context, int index) {
//            return ConversationItem(
//                Provider.of<MessageModel>(context, listen: true).ltMsg,
//                index,
//                0);
//          },
//          itemCount:
//              Provider.of<MessageModel>(context, listen: true).ltMsg.length,
//        ));
//  }
//}
