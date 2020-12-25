import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_assets/ran_flutter_assets.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/model/message_content_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ran_flutter_message/widgets/message_content/file/message_content_file_model.dart';
import 'package:ran_flutter_message/widgets/message_content/file/message_content_voice_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageContentFileWidget extends StatelessWidget {
  const MessageContentFileWidget({
    Key key,
    @required this.messageContentFile,
    @required this.styleType,
  }) : super(key: key);

  final MessageContentFileModel messageContentFile;
  final int styleType;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var isAudio = RegexUtils.isAudio(messageContentFile.fileName);
    print('是不是音频：${isAudio}');
    if (isAudio) {
      return MessageContentVoiceWidget(
        fileId: messageContentFile.fileId,
        styleType: styleType,
      );
    }
    return InkWell(
      onTap: () async {
        try {
          EasyLoading.show();
          FileItem fileItemRes =
              await AssetsRepository.fetchFileItem(messageContentFile.fileId);
          launch(fileItemRes.webUrl, forceSafariVC: false);
          EasyLoading.dismiss();
        } catch (e, s) {
          print(e.toString());
          EasyLoading.dismiss();
        }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: width / 1.5),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(messageContentFile.fileName),
                SizedBox(
                  height: 5,
                ),
                Text(
                  Utils.renderSize(messageContentFile.fileSize.toDouble()),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            )),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

Widget getMessageContentFileWidgetBuild(
    MessageContentModel messageContent, int styleType) {
  return MessageContentFileWidget(
      messageContentFile:
          MessageContentFileModel.fromJson(messageContent.content),
      styleType: styleType);
}
