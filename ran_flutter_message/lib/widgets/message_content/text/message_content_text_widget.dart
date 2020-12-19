import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/model/message_content_model.dart';
import 'package:ran_flutter_message/widgets/bubble.dart';
import 'package:ran_flutter_message/widgets/message_content/text/message_content_text_model.dart';

class MessageContentTextWidget extends StatelessWidget {
  const MessageContentTextWidget({
    Key key,
    @required this.messageContentText,
    @required this.senderType,
  }) : super(key: key);

  final MessageContentTextModel messageContentText;
  final int senderType;

  BubbleStyle getItemBundleStyle() {
    BubbleStyle styleSend = BubbleStyle(
      nip: BubbleNip.rightText,
      color: Color.fromRGBO(169, 233, 121, 1),
      nipOffset: 5,
      nipWidth: 10,
      nipHeight: 10,
      margin: BubbleEdges.only(left: 50.0),
      padding: BubbleEdges.only(top: 8, bottom: 10, left: 10, right: 15),
    );
    BubbleStyle styleReceive = BubbleStyle(
      nip: BubbleNip.leftText,
      color: Colors.white,
      nipOffset: 5,
      nipWidth: 10,
      nipHeight: 10,
      margin: BubbleEdges.only(right: 50.0),
      padding: BubbleEdges.only(top: 8, bottom: 10, left: 10, right: 15),
    );

    return senderType == 0 ? styleSend : styleReceive;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    print(RegexUtils.isImage('app.PNG'));
    if (senderType == 2) {
      return Text(
        messageContentText?.content ?? '',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }
    return Container(
      constraints: BoxConstraints(maxWidth: width / 1.5),
      child: Bubble(
          style: getItemBundleStyle(),
          child: Linkify(
            onOpen: (link) async {
              NavigatorUtils.goWebViewPage(context, link.url);
            },
            text: messageContentText?.content ?? '',
            style: TextStyle(color: Colors.black),
            linkStyle: TextStyle(color: Colors.blue),
          )
//        Text(
//          messageContentText?.content ?? '',
//          style: TextStyle(fontSize: 15, color: Colors.black),
//        ),
          ),
    );
  }
}

Widget getMessageContentTextWidgetBuild(
    MessageContentModel messageContent, int senderType) {
  return MessageContentTextWidget(
      messageContentText:
          MessageContentTextModel.fromJson(messageContent.content),
      senderType: senderType);
}
