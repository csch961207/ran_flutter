import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/model/message_content_model.dart';
import 'package:ran_flutter_message/widgets/message_content/file/message_content_file_model.dart';

class MessageListContentFileWidget extends StatelessWidget {
  const MessageListContentFileWidget({
    Key key,
    @required this.messageContentFile,
  }) : super(key: key);

  final MessageContentFileModel messageContentFile;

  @override
  Widget build(BuildContext context) {
    var isAudio = RegexUtils.isAudio(messageContentFile.fileName);
    print('是不是音频：${isAudio}');
    return new Text(
      isAudio ? '[语音]' : '[文件]',
      style: TextStyle(fontSize: 15, color: Colors.grey),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

Widget getMessageListContentFileWidgetBuild(
    MessageContentModel messageContent) {
  return MessageListContentFileWidget(
    messageContentFile:
        MessageContentFileModel.fromJson(messageContent.content),
  );
}
