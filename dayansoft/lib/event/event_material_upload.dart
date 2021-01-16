import 'dart:io';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:dayansoft/config/routers/fluro_navigator.dart';
import 'package:dayansoft/db/file/file_db_provider.dart';
import 'package:dayansoft/event/event_router.dart';
import 'package:dayansoft/event/shoot_page.dart';
import 'package:dayansoft/model/eventFile.dart';
import 'package:dayansoft/res/colors.dart';
import 'package:camera/camera.dart';
import 'package:dayansoft/utils/toast_util.dart';
import 'package:dayansoft/widget/view_state_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../res/colors.dart';

class EventMaterialUploadPage extends StatefulWidget {
  const EventMaterialUploadPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  final int id;
  @override
  _EventMaterialUploadPageState createState() =>
      _EventMaterialUploadPageState();
}

class _EventMaterialUploadPageState extends State<EventMaterialUploadPage> {
  FileDbProvider provider = new FileDbProvider();
  Location _location;
  List<EventFile> eventFiles = [];

  @override
  void initState() {
    super.initState();
    getList();
    getLocation();
  }

  getLocation() async {
    try {
      if (await Permission.locationAlways.serviceStatus.isEnabled) {
        final location = await AmapLocation.instance.fetchLocation();
        setState(() => _location = location);
      } else {
        ToastUtil.show('无定位权限');
        NavigatorUtils.goBack(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = false;

  getList() async {
    print('获取文件列表');
    try {
      List<EventFile> listData = await provider.getFilesByEventId(widget.id);
      print(listData);
      setState(() {
        eventFiles = listData;
      });
    } catch (e) {
      print(e);
    }
  }

  insert(String filePath) async {
    print('位置');
    print(_location);
    try {
      EventFile eventFile = EventFile();
      eventFile.eventId = widget.id;
      eventFile.filePath = filePath;
      var name = filePath.substring(filePath.lastIndexOf("/") + 1);
      eventFile.filename = 'ns_${name}_1.jpg';
      eventFile.photoshootpositionLat = _location.latLng.latitude;
      eventFile.photoshootpositionLng = _location.latLng.longitude;
      await provider.insert(eventFile);
      getList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
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
                CupertinoIcons.cloud_upload,
                size: 24,
              ),
              onPressed: () {
                print('上传');
              }),
        ]);
    var color = Theme.of(context).accentColor;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var appBarHeight = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      backgroundColor: Color(0xFFF3F2F2),
      body: isLoading
          ? Center(
              child: ViewStateBusyWidget(),
            )
          : SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '待上传',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: height - appBarHeight,
                  child: AnimationLimiter(
                    child: GridView.builder(
                      itemCount: eventFiles.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //横轴元素个数
                          crossAxisCount: 3,
                          //纵轴间距
                          mainAxisSpacing: 10.0,
                          //横轴间距
                          crossAxisSpacing: 10.0,
                          //子组件宽高长度比例
                          childAspectRatio: 1.0),
                      itemBuilder: (context, index) {
                        File file = new File(eventFiles[index].filePath);
                        return AnimationConfiguration.staggeredGrid(
                          columnCount: eventFiles.length,
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                color: Theme.of(context).primaryColor,
                                child: ExtendedImage.file(
                                  file,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.fill,
                                  border:
                                      Border.all(color: Colors.red, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  initGestureConfigHandler: (state) {
                                    return GestureConfig(
                                      minScale: 0.9,
                                      animationMinScale: 0.7,
                                      maxScale: 3.0,
                                      animationMaxScale: 3.5,
                                      speed: 1.0,
                                      inertialSpeed: 100.0,
                                      initialScale: 1.0,
                                      inPageView: false,
                                      initialAlignment: InitialAlignment.center,
                                    );
                                  },
                                  //cancelToken: cancellationToken,
                                ),
//                                ExtendedImage.file(
//                                  file,
//                                  width: 40,
//                                  height: 40,
//                                  fit: BoxFit.fill,
//                                  border:
//                                      Border.all(color: Colors.red, width: 1.0),
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(30.0)),
//                                  //cancelToken: cancellationToken,
//                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            )),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 38,
        ),
        onPressed: () async {
          print('FloatingActionButton');
          final AssetEntity entity = await CameraPicker.pickFromCamera(context,
              isAllowRecording: true,
              theme: ThemeData(
                  accentColor: Colours.app_main,
                  primaryColor: Colors.white,
                  textTheme: Theme.of(context).textTheme.apply(
                        bodyColor: Colors.white,
                        displayColor: Colors.white,
                      )));
          print(entity.file);
          File file = await entity.file;
          print(file.path);
          insert(file.path);
        },
      ),
    );
  }
}
