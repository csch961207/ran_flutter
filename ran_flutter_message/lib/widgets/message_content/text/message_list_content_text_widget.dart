import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_message/model/message_content_model.dart';
import 'package:ran_flutter_message/widgets/message_content/text/message_content_text_model.dart';


class MessageListContentTextWidget extends StatefulWidget {
  final MessageContentModel messageContent;
  MessageListContentTextWidget({Key key, this.messageContent})
      : super(key: key);

  @override
  MessageListContentTextWidgetState createState() =>
      MessageListContentTextWidgetState();
}

class MessageListContentTextWidgetState
    extends State<MessageListContentTextWidget> {
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
      style: TextStyle(fontSize: 15, color: Colors.grey),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

Widget getMessageListContentTextWidgetBuild(
    MessageContentModel messageContent) {
  return MessageListContentTextWidget(
    messageContent: messageContent,
  );
}
