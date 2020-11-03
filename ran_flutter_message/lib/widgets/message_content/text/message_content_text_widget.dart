import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_message/model/message_content_model.dart';
import 'package:ran_flutter_message/widgets/message_content/text/message_content_text_model.dart';

class MessageContentTextWidget extends StatefulWidget {
  final MessageContentModel messageContent;
  final int styleType;
  MessageContentTextWidget({Key key, this.messageContent, this.styleType})
      : super(key: key);

  @override
  MessageContentTextWidgetState createState() =>
      MessageContentTextWidgetState();
}

class MessageContentTextWidgetState extends State<MessageContentTextWidget> {
  MessageContentTextModel messageContentText = new MessageContentTextModel();

  @override
  void initState() {
    super.initState();
    messageContentText =
        MessageContentTextModel.fromJson(widget.messageContent.content);
  }

  @override
  Widget build(BuildContext context) {
    return new Text(
      messageContentText?.content ?? '',
      style: TextStyle(
          fontSize: 15,
          color: widget.styleType == 2 ? Colors.grey : Colors.black),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

Widget getMessageContentTextWidgetBuild(
    MessageContentModel messageContent, int styleType) {
  return MessageContentTextWidget(
      messageContent: messageContent, styleType: styleType);
}
