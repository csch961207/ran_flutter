import 'package:dignite_dangjian_flutter_app/meeting/model/upload_file_list_model.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ran_flutter_assets/ran_flutter_assets.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../meeting_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MeetingPicturesPage extends StatefulWidget {
  const MeetingPicturesPage({
    Key key,
    @required this.meetingId,
  }) : super(key: key);

  final String meetingId;
  @override
  _MeetingPicturesPageState createState() => _MeetingPicturesPageState();
}

class _MeetingPicturesPageState extends State<MeetingPicturesPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Blobs blobs = new Blobs();
  final picker = ImagePicker();
  List<UploadFileListModel> listFile = [];

  void loadData() async {
    EasyLoading.show();
    try {
      Blobs res = await AssetsRepository.fetchBlobsFileList(
          "dangjian-meet-pictures", widget.meetingId);
      setState(() {
        blobs = res;
      });
      EasyLoading.dismiss();
    } catch (e, s) {
      print(e.toString());
      EasyLoading.dismiss();
      getErrorTips(e, s, context: this.context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    String userName = Provider.of<CoreViewModel>(context, listen: false)
        ?.applicationConfiguration
        ?.currentUser
        ?.userName;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '现场照片',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: APPColors.app_main,
          iconTheme: IconThemeData(color: Colors.white),
//        elevation: 1.0,
          actions: [
            IconButton(
              tooltip: '更多',
              icon: Icon(
                CupertinoIcons.ellipsis,
                size: 21,
              ),
              color: Colors.white,
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,

                  /// 使用true则高度不受16分之9的最高限制
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: 110,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                if (blobs.items == null ||
                                    blobs.items.length == 0) {
                                  return;
                                }
                                EasyLoading.show();
                                try {
                                  List<Future> list = [];
                                  for (var i = 0; i < blobs.items.length; i++) {
                                    list.add(MeetingRepository.putAutoSignIn(
                                        widget.meetingId,
                                        blobs.items[i].blobName));
                                  }
                                  Future.wait(list);
                                  await Provider.of<DangjianViewModel>(
                                          this.context,
                                          listen: false)
                                      .getMeetingList();
                                  ToastUtil.show('检测完成');
                                  EasyLoading.dismiss();
                                } catch (e, s) {
                                  print(e.toString());
                                  EasyLoading.dismiss();
//                    getErrorTips(e, s, context: this.context);
                                }
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xffe5e5e5))),
                                    ),
                                    alignment: Alignment.center,
                                    height: 50,
                                    child: Text(
                                      '人脸检测',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            color: Color(0xFFf5f5f5),
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    height: 50,
                                    child: Text(
                                      '取消',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    );
                  },
                );
              },
            )
          ]),
//      backgroundColor: Color(0xFFF3F2F2),

      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//                    Container(
//                      margin: EdgeInsets.all(20),
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        borderRadius: BorderRadius.circular(5.0),
//                      ),
//                      child: ,
//                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                          blobs.items?.length ?? 0,
                          (index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          new PhotoViewSimpleScreen(
                                            imageProvider: NetworkImage(
                                                ConfigService.getApiUrl() +
                                                    "/host/" +
                                                    blobs.items[index]
                                                        .containerName +
                                                    "/" +
                                                    blobs
                                                        .items[index].blobName),
                                            heroTag: 'simple',
                                          )));
                                },
                                onLongPress: () {
                                  showModalBottomSheet(
                                    isDismissible: false,
                                    backgroundColor: Colors.transparent,
                                    context: context,

                                    /// 使用true则高度不受16分之9的最高限制
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 110,
                                        child: Column(
                                          children: <Widget>[
                                            GestureDetector(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  showElasticDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext
                                                          context) {
                                                        return BaseDialog(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: const Text(
                                                                "你确定要删除吗？",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                          onPressed: () async {
                                                            NavigatorUtils
                                                                .goBack(
                                                                    context);
                                                            try {
                                                              EasyLoading
                                                                  .show();
                                                              String code = await AssetsRepository.deleteBlobFile(
                                                                  blobs
                                                                      .items[
                                                                          index]
                                                                      .containerName,
                                                                  blobs
                                                                      .items[
                                                                          index]
                                                                      .blobName);
                                                              if (code ==
                                                                      "204" ||
                                                                  code ==
                                                                      "200") {
                                                                loadData();
                                                                EasyLoading
                                                                    .dismiss();
                                                                ToastUtil.show(
                                                                    '删除成功');
                                                              }
                                                              EasyLoading
                                                                  .dismiss();
                                                            } catch (e, s) {
                                                              EasyLoading
                                                                  .dismiss();
                                                              getErrorTips(e, s,
                                                                  context:
                                                                      context);
                                                              print(e);
                                                            }
                                                          },
                                                        );
                                                      });
                                                },
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      height: 50,
                                                      child: Text(
                                                        '删除',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 16),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            Container(
                                              color: Color(0xFFf5f5f5),
                                              height: 10,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      height: 50,
                                                      child: Text(
                                                        '取消',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    child: LoadImage(
                                        ConfigService.getApiUrl() +
                                            "/host/" +
                                            blobs.items[index].containerName +
                                            "/" +
                                            blobs.items[index].blobName,
//                                    height: 90.0,
                                        holderImg: 'picture_failed',
                                        fit: BoxFit.fitWidth,
                                        format: 'png'),
                                  ),
                                ),
                              )),
                    ),
                    Column(
                      children: List.generate(
                          listFile.length,
                          (index) => listFile[index].isComplete
                              ? SizedBox()
                              : Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              minHeight: 200,
                            ),
                                  margin: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Opacity(
                                        opacity: 0.5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            child: Image.file(
                                                listFile[index].file,),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          listFile[index].isFail ? SizedBox() : CircularProgressIndicator(
                                            backgroundColor: Colors.grey[200],
//                              valueColor: AlwaysStoppedAnimation(Colors.blue),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            listFile[index].isFail ? "上传失败" : "正在上传...",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          listFile[index].isFail ? GestureDetector(
                                              onTap: () async {
                                                await uploadFile(isUploadAgain: true,index: index);
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                //设置 child 居中
                                                alignment: Alignment(0, 0),
                                                height: 30,
                                                width: 90,
                                                //边框设置
                                                decoration: new BoxDecoration(
                                                  //背景
                                                  color: Colors.transparent,
                                                  //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              25.0)),
                                                  //设置四周边框
                                                  border: new Border.all(
                                                      width: 0.9,
                                                      color: Colors.white),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "重新上传",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              )) : SizedBox()
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                    )
                  ],
                ),
              )),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
            child: Container(
              child: RanButton(
                text: '拍照',
                onPressed: () async {
                  try {
                    var blobName = await uploadFile(isUploadAgain: false);
                    loadData();
                    int index = blobName.indexOf("/");
                    var res = await MeetingRepository.putAutoSignIn(
                        widget.meetingId, blobName.substring(index + 1));
                    if (res == "200" || res == "204") {
                      await Provider.of<DangjianViewModel>(this.context,
                              listen: false)
                          .getMeetingList();
                      ToastUtil.show('自动识别已完成');
                    }
                  } catch (e, s) {
                    print(e.toString());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  uploadFile({isUploadAgain,index}) async {
    String filePath;
    if(!isUploadAgain){
      var file = await picker.getImage(source: ImageSource.camera);
//    Image.file(File(_fileName));
      listFile.add(new UploadFileListModel(
          file: File(file.path),
          isUploading: true,
          isComplete: false,
          isFail: false));
      filePath = file.path;
    } else {
      listFile[index].isUploading = true;
      listFile[index].isComplete = false;
      listFile[index].isFail = false;
      filePath = listFile[index].file.path;
    }
    setState(() {});
    try {
      var blobName = await AssetsRepository.blobsUpload(filePath,
          "dangjian-meet-pictures", widget.meetingId, "MeetingPicture");
      listFile[listFile.length - 1].isUploading = false;
      listFile[listFile.length - 1].isComplete = true;
      Blobs res = await AssetsRepository.fetchBlobsFileList(
          "dangjian-meet-pictures", widget.meetingId);
      blobs = res;
      setState(() {});
      return blobName;
    } catch (e, s) {
      print(e.toString());
      listFile[listFile.length - 1].isFail = true;
      setState(() {});
    }
  }
}
