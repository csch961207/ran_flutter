import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/model/message_content_model.dart';
import 'package:ran_flutter_message/widgets/message_content/picture/message_content_picture_model.dart';

class MessageContentPictureWidget extends StatelessWidget {
  const MessageContentPictureWidget({
    Key key,
    @required this.messageContentPicture,
    @required this.styleType,
  }) : super(key: key);

  final MessageContentPictureModel messageContentPicture;
  final int styleType;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => new PhotoViewSimpleScreen(
                  minScale: 0.1,
                  maxScale: 0.5,
                  imageProvider: NetworkImage(messageContentPicture.webUrl),
                  heroTag: 'simple',
                )));
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: width / 2),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LoadImage(messageContentPicture.webUrl,
                holderImg: 'imagePlaceholder', fit: BoxFit.fill)),
      ),
    );
  }
}

Widget getMessageContentPictureWidgetBuild(
    MessageContentModel messageContent, int styleType) {
  return MessageContentPictureWidget(
      messageContentPicture:
          MessageContentPictureModel.fromJson(messageContent.content),
      styleType: styleType);
}
