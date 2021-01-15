import 'dart:io';

import 'package:dayansoft/config/routers/fluro_navigator.dart';
import 'package:dayansoft/event/event_router.dart';
import 'package:dayansoft/event/shoot_page.dart';
import 'package:dayansoft/res/colors.dart';
import 'package:camera/camera.dart';
import 'package:dayansoft/widget/view_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../res/colors.dart';

class EventMaterialUploadPage extends StatefulWidget {
  const EventMaterialUploadPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;
  @override
  _EventMaterialUploadPageState createState() =>
      _EventMaterialUploadPageState();
}

class _EventMaterialUploadPageState extends State<EventMaterialUploadPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = false;
//  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '物料上传',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
          actions: <Widget>[
            /// 刷新、在浏览器中打开、复制链接、分享
            IconButton(
                tooltip: '上传',
                icon: Icon(
                  Icons.cloud_upload_outlined,
                  size: 28,
                ),
                onPressed: () {
                  print('上传');
                }),
          ]),
      backgroundColor: Color(0xFFF3F2F2),
      body: isLoading
          ? Center(
              child: ViewStateBusyWidget(),
            )
          : SingleChildScrollView(child: Text('')),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 38,
        ),
        onPressed: () async {
          print('FloatingActionButton');
//          List<CameraDescription> cameras;
//
//          WidgetsFlutterBinding.ensureInitialized();
//          cameras = await availableCameras();
//          Navigator.of(context).push(
//              MaterialPageRoute(builder: (context) => new ShootPage(cameras)));
//          NavigatorUtils.push(context, EventRouter.cameraApp);
          final AssetEntity entity = await CameraPicker.pickFromCamera(context,
              isAllowRecording: true,
              theme: ThemeData(
                  accentColor: Colours.app_main,
                  primaryColor: Colors.white,
                  textTheme: Theme.of(context).textTheme.apply(
                        bodyColor: Colors.white,
                        displayColor: Colors.white,
                      )));
//          final pickedFile = await picker.getVideo(source: ImageSource.camera);
          print(entity.file);
          File file = await entity.file;
          print(file.path);
        },
      ),
    );
  }
}
