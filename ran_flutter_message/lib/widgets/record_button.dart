import 'dart:async';
import 'dart:io' as io;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ran_flutter_assets/ran_flutter_assets.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/widgets/ImagesAnimation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ran_flutter_message/widgets/message_send_content_types.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';

OverlayEntry mOverlayEntry;

String mButtonText = "按住 说话";
String mCenterTipText = "";
final LocalFileSystem mLocalFileSystem = new LocalFileSystem();

double startY = 0.0;
double endY = 0.0;
double offsetY = 0.0;

int mSatrtRecordTime = 0;

/**
 * 最短说话时间
 **/
int MIN_INTERVAL_TIME = 1000;

String voiceIco = 'packages/ran_flutter_message/' +
    ImageHelper.wrapAssets('ic_volume_1.png');

List<String> _assetList = new List();

bool showAnim = true;

typedef void OnAudioCallBack(Map<String, Object> mAudioFile, int duration);

class RecordButton extends StatefulWidget {
  final OnAudioCallBack onAudioCallBack;

  const RecordButton({
    Key key,
    this.onAudioCallBack,
  }) : super(key: key);

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

///显示说话悬浮布局
buildOverLayView(BuildContext context) {
  if (mOverlayEntry == null) {
    mOverlayEntry = new OverlayEntry(builder: (content) {
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.5 - 80,
        left: MediaQuery.of(context).size.width * 0.5 - 80,
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Opacity(
              opacity: 0.8,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: showAnim
                            ? VoiceAnimationImage(
                          _assetList,
                          width: 100,
                          height: 100,
                          isStop: true,
                        )
                            : new Image.asset(
                          voiceIco,
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        )),
                    Container(
//                      padding: EdgeInsets.only(right: 20, left: 20, top: 0),
                      child: Text(
                        mCenterTipText,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
    Overlay.of(context).insert(mOverlayEntry);
  }
}

Map<int, Image> imageCaches = new Map();

class _RecordButtonState extends State<RecordButton> {
//  Recording _recording = new Recording();

  startRecord() async {
    print("开始说话");
//    String customPath = '/sq_';
//    io.Directory appDocDirectory;
////        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
//    if (io.Platform.isIOS) {
//      appDocDirectory = await getApplicationDocumentsDirectory();
//    } else {
//      appDocDirectory = await getExternalStorageDirectory();
//    }
//    // can add extension like ".mp4" ".wav" ".m4a" ".aac"
//    customPath = appDocDirectory.path +
//        customPath +
//        DateTime.now().millisecondsSinceEpoch.toString();
////    io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
////    String path = appDocDirectory.path +
////        '/' +
////        new DateTime.now().millisecondsSinceEpoch.toString();
//    print("开始说话");
//    await FlutterRecordPlugin.start(
//        path: customPath, audioOutputFormat: AudioOutputFormat.AAC);
//    bool isRecording = await FlutterRecordPlugin.isRecording;
    await _start();
  }

  cancelRecord() async {
//    var recording = await FlutterRecordPlugin.stop();
    await _stop();
    File file = mLocalFileSystem.file(_current.path);
    file.delete();
    print("取消说话删除文件成功!");
    if (mOverlayEntry != null) {
      mOverlayEntry.remove();
      mOverlayEntry = null;
    }
    //  }
    //   });
    setState(() {
      //_recording = recording;
    });
  }

  completeRecord() async {
    int intervalTime =
        new DateTime.now().millisecondsSinceEpoch - mSatrtRecordTime;
    if (intervalTime < MIN_INTERVAL_TIME) {
      print("说话时间太短");
      mCenterTipText = "说话时间太短";
      voiceIco = 'packages/ran_flutter_message/' +
          ImageHelper.wrapAssets('ic_volume_wraning.png');
      showAnim = false;
      mButtonText = "按住 说话";
      mOverlayEntry.markNeedsBuild();
      await _stop();
      File file = mLocalFileSystem.file(_current.path);
      file.delete();
      print("说话时间太短:删除文件成功!");
      if (mOverlayEntry != null) {
        Future.delayed(Duration(milliseconds: 500), () {
          mOverlayEntry.remove();
          mOverlayEntry = null;
        });
      }
    } else {
      print("说话完成");
      await _stop();
      print("Stop recording: ${_current.path}");
      File file = mLocalFileSystem.file(_current.path);
      print("  File length: ${_current.duration.inSeconds}");

      if (mOverlayEntry != null) {
        mOverlayEntry.remove();
        mOverlayEntry = null;
      }
      EasyLoading.show();
      try {
        String userId =
        StorageManager.sharedPreferences.getString("userId");
        FileItem fileRes = await AssetsRepository.upload(
            file.path, userId, MessageSendContentTypes.folderToken);
        EasyLoading.dismiss();
        Map<String, Object> result = {
          "contentTypeName": "File",
          "fileId": fileRes.id,
          "fileName": fileRes.name,
          "fileSize": fileRes.size,
        };
        widget.onAudioCallBack?.call(result, _current.duration.inSeconds);
      } catch (e, s) {
        print(e.toString());
        EasyLoading.dismiss();
      }

    }
  }

  bool flag = true; // member variable

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _assetList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets('ic_volume_1.png'));
    _assetList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets('ic_volume_2.png'));
    _assetList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets('ic_volume_3.png'));
    _assetList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets('ic_volume_4.png'));
    _assetList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets('ic_volume_5.png'));
    _assetList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets('ic_volume_6.png'));
    _assetList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets('ic_volume_7.png'));
    _assetList.add('packages/ran_flutter_message/' +
        ImageHelper.wrapAssets('ic_volume_8.png'));
    print(_assetList);
    _init();
  }

  double startY = 0.0;
  double endY = 0.0;
  double offsetY = 0.0;

  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  final LocalFileSystem mLocalFileSystem = new LocalFileSystem();

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/sq_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.AAC);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _resume() async {
    await _recorder.resume();
    setState(() {});
  }

  _pause() async {
    await _recorder.pause();
    setState(() {});
  }

  _stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    File file = mLocalFileSystem.file(result.path);
//    print("File length: ${await file.length()}");
    setState(() {
      _current = result;
      _currentStatus = _current.status;
    });
  }

  @override
  Widget build(BuildContext context) {
    //buildGestureOverLayView(context);
    return Container(
      /* width: MediaQuery.of(context).size.width,*/
      //height: MediaQuery.of(context).size.height,
      //   color: Colors.deepOrange,
      child: GestureDetector(
        onVerticalDragStart: (details) {
          if (flag) {
            flag = false;
            Future.delayed(const Duration(milliseconds: 500), () {
              flag = true;
            });
            mCenterTipText = "手指上滑,取消发送";
            mButtonText = "松开发送";
            showAnim = true;
            buildOverLayView(context);
            setState(() {});
            startRecord();
            startY = details.globalPosition.dy;
            mSatrtRecordTime = new DateTime.now().millisecondsSinceEpoch;
          }
        },
        onVerticalDragEnd: (details) {
          setState(() {
            mButtonText = "按住 说话";
          });
          if (offsetY >= 150) {
            print("执行取消说话:" + offsetY.toString());
            cancelRecord();
          } else {
            completeRecord();
          }
        },
        onVerticalDragUpdate: (details) {
          endY = details.globalPosition.dy;
          offsetY = startY - endY;
          print("偏移量是:" + "(${offsetY})");
          if (offsetY >= 150) {
            //当手指向上滑，会cancel
            mCenterTipText = "松开手指,取消发送";
            voiceIco = 'packages/ran_flutter_message/' +
                ImageHelper.wrapAssets('ic_volume_cancel.png');
            showAnim = false;
            mOverlayEntry.markNeedsBuild();
            setState(() {
              mButtonText = "按住 说话";
            });
            /* stopRecording();
                   recordDialog.dismiss();
                   File file = new File(mFile);
                   file.delete();*/
          } else {
            mCenterTipText = "手指上滑,取消发送";
            mButtonText = "松开发送";
            showAnim = true;
            mOverlayEntry.markNeedsBuild();
          }
        },
        child: Container(
          height: 40,
          decoration: new BoxDecoration(
            //背景
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
//            //设置四周边框
//            border: new Border.all(width: 1, color: Color(0xffD2D2D2)),
          ),
          child: Center(
            child: Text(
              mButtonText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
