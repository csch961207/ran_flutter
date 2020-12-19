import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_assets/ran_flutter_assets.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/widgets/bubble.dart';
import 'package:ran_flutter_message/widgets/voice_animation.dart';

class MessageContentVoiceWidget extends StatefulWidget {
  final String fileId;
  final int styleType;
  MessageContentVoiceWidget({Key key, this.fileId, this.styleType})
      : super(key: key);

  @override
  MessageContentVoiceWidgetState createState() =>
      MessageContentVoiceWidgetState();
}

class MessageContentVoiceWidgetState extends State<MessageContentVoiceWidget> {
  List<String> mAudioAssetRightList = new List();
  List<String> mAudioAssetLeftList = new List();

  AudioPlayer mAudioPlayer = AudioPlayer();
  bool isStop = false;
  String mUUid = "";

  @override
  void initState() {
    super.initState();
    mAudioAssetRightList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets("audio_animation_list_right_1.png"));
    mAudioAssetRightList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets("audio_animation_list_right_2.png"));
    mAudioAssetRightList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets("audio_animation_list_right_3.png"));

    mAudioAssetLeftList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets("audio_animation_list_left_1.png"));
    mAudioAssetLeftList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets("audio_animation_list_left_2.png"));
    mAudioAssetLeftList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets("audio_animation_list_left_3.png"));
  }

  BubbleStyle getItemBundleStyle() {
    BubbleStyle styleSend = BubbleStyle(
      nip: BubbleNip.rightText,
      color: Color.fromRGBO(169, 233, 121, 1),
      nipOffset: 5,
      nipWidth: 10,
      nipHeight: 10,
      margin: BubbleEdges.only(left: 50.0),
      padding: BubbleEdges.only(top: 12, bottom: 12, left: 15, right: 10),
    );
    BubbleStyle styleReceive = BubbleStyle(
      nip: BubbleNip.leftText,
      color: Colors.white,
      nipOffset: 5,
      nipWidth: 10,
      nipHeight: 10,
      margin: BubbleEdges.only(right: 50.0),
      padding: BubbleEdges.only(top: 12, bottom: 12, left: 10, right: 15),
    );

    return widget.styleType == 0 ? styleSend : styleReceive;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async{
        setState(() {
          isStop = true;
        });
        if (widget.fileId != null) {
          try {
            FileItem fileItemRes =
                await AssetsRepository.fetchFileItem(widget.fileId);
            Future<int> result = mAudioPlayer.play(fileItemRes.webUrl, isLocal: true);
            mAudioPlayer.onPlayerCompletion.listen((event) {
              setState(() {
                isStop = false;
              });
            });
          } catch (e, s) {
            print(e.toString());
            getErrorTips(e, s, context: context);
          }
        }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: width / 1.5),
        child: Bubble(
            style: getItemBundleStyle(),
            child: VoiceAnimationImage(
              widget.styleType == 0
                  ? mAudioAssetRightList
                  : mAudioAssetLeftList,
              width: 30,
              height: 15,
              isStop: isStop,
            )),
      ),
    );
  }
}
