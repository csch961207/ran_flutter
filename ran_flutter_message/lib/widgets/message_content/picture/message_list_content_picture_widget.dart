import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_message/model/message_content_model.dart';

class MessageListContentPictureWidget extends StatelessWidget {
  const MessageListContentPictureWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return new Text(
      '[图片]',
      style: TextStyle(fontSize: 15, color: Colors.grey),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

Widget getMessageListContentPictureWidgetBuild(
    MessageContentModel messageContent) {
  return MessageListContentPictureWidget();
}
