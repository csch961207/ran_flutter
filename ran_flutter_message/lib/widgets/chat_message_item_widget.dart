import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/message_provider.dart';

import 'package:ran_flutter_message/model/chat_message_model.dart';
import 'package:ran_flutter_message/model/message_content_model.dart';
import 'package:ran_flutter_message/widgets/bubble.dart';

class ChatMessageItemWidget extends StatefulWidget {
  final ChatMessageItem chatMessageItem;

  ChatMessageItemWidget({Key key, this.chatMessageItem}) : super(key: key);

  @override
  ChatMessageItemWidgetState createState() => ChatMessageItemWidgetState();
}

class ChatMessageItemWidgetState extends State<ChatMessageItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser currentUser = Provider.of<CoreViewModel>(context, listen: false)
        .applicationConfiguration
        .currentUser;
    var tapPos;
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: widget.chatMessageItem.senderId == null
                ? getMessageLayout()
                : widget.chatMessageItem.senderId == currentUser.id
                    ? getSentMessageLayout()
                    : getReceivedMessageLayout(),
          ),
          onTapDown: (TapDownDetails details) {
            tapPos = details.globalPosition;
          },
          onLongPress: () {},
        )
      ],
    );
  }

//  无发送者消息布局
  Widget getMessageLayout() {
    return Container(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: MessageProvider.getMessageContentProviderWidget(
                  MessageContentModel.fromJson(widget.chatMessageItem.content),
                  2),
              margin: EdgeInsets.only(bottom: 5.0, top: 2),
            ),
          ],
        ));
  }

//  发送者布局
  Widget getSentMessageLayout() {
    return Container(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  MessageProvider.getMessageContentProviderWidget(
                      MessageContentModel.fromJson(
                          widget.chatMessageItem.content),
                      0)
                ],
              ),
              margin: EdgeInsets.only(bottom: 5.0, top: 2),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: LoadImage('profilePicture',
                        holderImg: 'logo_icon',
                        height: 45.0,
                        width: 45.0,
                        fit: BoxFit.fill))),
          ],
        ));
  }

//  接收者类型
  Widget getReceivedMessageLayout() {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(
          //  mainAxisAlignment:MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 5.0, left: 10, top: 2),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: LoadImage('received_picture',
                        holderImg: 'logo_icon',
                        height: 45.0,
                        width: 45.0,
                        fit: BoxFit.fill))),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: widget.chatMessageItem.receiverType == 1,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 3, left: 10),
                        child: Text(
                          widget.chatMessageItem?.senderName ?? '',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ),
                    MessageProvider.getMessageContentProviderWidget(
                        MessageContentModel.fromJson(
                            widget.chatMessageItem.content),
                        1),
//                    Bubble(
//                      style: getItemBundleStyle(widget.chatMessageItem),
//                      child: ,
//                    ),
                  ]),
              margin: EdgeInsets.only(
                bottom: 5.0,
              ),
            ),
          ],
        ));
  }
}
