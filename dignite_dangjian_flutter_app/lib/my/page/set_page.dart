import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ran_flutter_account/ran_flutter_account.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';

class SetPage extends StatefulWidget {
  @override
  _SetPageState createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  void initState() {
    super.initState();
    getVersion();
    loadCache();
  }

  String cacheFileSize = '';

  Future<Null> loadCache() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    print('临时目录大小: ' + value.toString());
    print('临时目录大小: ' + Utils.renderSize(value));
    String size = Utils.renderSize(value);
    setState(() {
      cacheFileSize = size;
    });
  }

  Future _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  //递归方式删除目录
  Future<Null> delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    await file.delete();
  }

  String title;
  String content;
  String url;
  String currentVersion = '';
  String newestVersion = '';
  String appUpdateUrl = '';

  /// 检查更新
  getVersion() async {
//    EasyLoading.show();
//    PackageInfo packageInfo = await PackageInfo.fromPlatform();
//    String version = packageInfo.version;
//    setState(() {
//      currentVersion = version;
//      newestVersion = version;
//    });
//    try {
//      String entityTypeId;
//      if (Platform.isAndroid) {
//        entityTypeId = 'cd4beaa9-b139-4dbb-af80-c49b37940609';
//      } else if (Platform.isIOS) {
//        entityTypeId = '745f111a-05c5-477e-8fac-7ca8c8ee597b';
//      }
//      Entities entities = await SiteRepository.fetchEntities(
//          'a6ca1b86-2735-cf3b-5f64-39f980c88d4a',
//          entityTypeId: entityTypeId);
//      if (entities.items.length != 0) {
//        FieldValue versionName = entities.items[0].fieldValues.firstWhere(
//            (fieldValue) =>
//                fieldValue.fieldId == "6f4f15d7-87df-9f23-9e34-39f980ccdea0");
//        FieldValue versionContent = entities.items[0].fieldValues.firstWhere(
//            (fieldValue) =>
//                fieldValue.fieldId == "ac4eba5a-3f88-c5f8-02bd-39f980cacff7");
//        FieldValue downloadUrl = entities.items[0].fieldValues.firstWhere(
//            (fieldValue) =>
//                fieldValue.fieldId == "9ab3ea18-21e1-f308-1bc4-39fa2a8b3816");
//        setState(() {
//          title = entities.items[0].title;
//          content = versionContent.maxTextValue;
//          newestVersion = versionName.indexTextValue;
//          appUpdateUrl = downloadUrl.maxTextValue;
//        });
//      }
//      EasyLoading.dismiss();
//    } catch (e) {
//      print(e);
//      EasyLoading.dismiss();
//    }
  }

  showUpdateDialog() {
    if (currentVersion != newestVersion) {
      UpdateUtil.showUpdateDialog(context, title, content, appUpdateUrl);
    } else {
      ToastUtil.show('当前已是最新版');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    String id = Provider.of<CoreViewModel>(context, listen: false)
        ?.applicationConfiguration
        ?.currentUser
        ?.id;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设置',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: APPColors.app_main,
        iconTheme: IconThemeData(color: Colors.white),
//        elevation: 1.0,
      ),
      backgroundColor: Color(0xFFF3F2F2),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
//              SizedBox(
//                height: 2,
//              ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                ClickItem(
                  title: "清理缓存",
                  content: cacheFileSize,
                  onTap: () async {
                    print('打印');
                    showElasticDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return BaseDialog(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: const Text("你确定要清理缓存吗？",
                                  textAlign: TextAlign.center),
                            ),
                            onPressed: () async {
                              NavigatorUtils.goBack(context);
                              try {
                                Directory file = await getTemporaryDirectory();
                                delDir(file);
                                loadCache();
                              } catch (e) {
                                print(e);
                              }
                            },
                          );
                        });
                  },
                ),
                ClickItem(
                  title: "检查更新",
                  content: currentVersion,
                  widgetContent: Text(
                    currentVersion != newestVersion ? '有更新' : currentVersion,
                    style: TextStyle(
                        color: currentVersion != newestVersion
                            ? Colors.red
                            : Colors.black),
                  ),
                  onTap: () {
                    print('打印');
                    showUpdateDialog();
                  },
                ),
                id != null
                    ? ClickItem(
                        title: "修改密码",
                        content: '',
                        onTap: () {
                          print('打印');
                          NavigatorUtils.push(
                              context, AccountRouter.updatePassword);
                        },
                      )
                    : SizedBox(),
                id != null ? ClickItem(
                  title: "退出当前帐号",
                  content: '',
                  onTap: () {
                    showElasticDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return BaseDialog(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: const Text("你确定要退出登录吗？",
                                  textAlign: TextAlign.center),
                            ),
                            onPressed: () async {
                              NavigatorUtils.goBack(context);
                              StorageManager.sharedPreferences
                                  .setString("accessToken", '');
                              Provider.of<CoreViewModel>(context, listen: false)
                                  .init();
                              NavigatorUtils.push(context, AccountRouter.login,
                                  transition: TransitionType.inFromBottom,clearStack: true);
                            },
                          );
                        });
                  },
                ) : SizedBox(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
