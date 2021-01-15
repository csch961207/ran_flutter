import 'dart:convert';
import 'dart:io';

import 'package:dayansoft/widget/base_dialog.dart';
import 'package:dayansoft/widget/click_item.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:flutter/cupertino.dart';
import 'package:launch_review/launch_review.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../account/account_router.dart';
import '../config/resource_mananger.dart';
import '../config/routers/fluro_navigator.dart';
import '../config/storage_manager.dart';
import '../model/user.dart';
import '../res/resources.dart';
import '../utils/utils.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  User user = new User();

  @override
  void initState() {
    super.initState();
    String data = StorageManager.sharedPreferences.getString("user");
    user = User.fromJson(json.decode(data));
    loadCache();
  }

  String cacheFileSize = '';

  renderSize(double value) {
    if (null == value) {
      return '0';
    }
    List<String> unitArr = List()..add('B')..add('KB')..add('MB')..add('GB');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  Future<Null> loadCache() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    print('临时目录大小: ' + value.toString());
    print('临时目录大小: ' + renderSize(value));
    String size = renderSize(value);
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('重新渲染');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设置',
          style: TextStyle(color: Colors.black),
        ),
//        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      ImageHelper.wrapAssets('account-logo.png'),
                      width: 60,
                      height: 60,
                      fit: BoxFit.fitWidth,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'v6.0.0',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ClickItem(
//                      iconWidget: Padding(
//                        padding: EdgeInsets.only(right: 5),
//                        child: Icon(CupertinoIcons.question_circle),
//                      ),
                      title: "当前账号",
                      content: user.userName,
                      onTap: () {},
                    ),
                    ClickItem(
//                      iconWidget: Padding(
//                        padding: EdgeInsets.only(right: 5),
//                        child: Icon(CupertinoIcons.question_circle),
//                      ),
                      title: "意见反馈",
                      content: '',
                      onTap: () async {
                        var url =
                            'mailto:1107554233@qq.com?subject=终端营销检查%20意见反馈&body=';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          await Future.delayed(Duration(seconds: 1));
                          launch('https://github.com/csch961207',
                              forceSafariVC: false);
                        }
                      },
                    ),
                    ClickItem(
//                      iconWidget: Padding(
//                        padding: EdgeInsets.only(right: 5),
//                        child: Icon(Icons.thumb_up_off_alt),
//                      ),
                      title: "好评鼓励",
                      content: '',
                      onTap: () async {
                        LaunchReview.launch(
                            androidAppId: "cn.dayansoft.app.dayansoft",
                            iOSAppId: "1423981796");
                      },
                    ),
                    ClickItem(
//                      iconWidget: Padding(
//                        padding: EdgeInsets.only(right: 5),
//                        child: Icon(Icons.clear),
//                      ),
                      title: "清理缓存",
                      content: cacheFileSize,
                      onTap: () {
                        showElasticDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return BaseDialog(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: const Text("你确定要清理缓存吗？",
                                      textAlign: TextAlign.center),
                                ),
                                onPressed: () async {
                                  NavigatorUtils.goBack(context);
                                  try {
                                    Directory file =
                                        await getTemporaryDirectory();
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
//                    ClickItem(
////                      iconWidget: Padding(
////                        padding: EdgeInsets.only(right: 5),
////                        child: Icon(Icons.clear),
////                      ),
//                      title: "关于我们",
//                      content: '',
//                      onTap: () {},
//                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(13),
                color: Colors.white,
                child: InkWell(
                  onTap: () async {
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
                                  .setString("user", '');
                              NavigatorUtils.push(
                                  context, AccountRouter.signInPage,
                                  transition: TransitionType.inFromBottom,
                                  clearStack: true);
                            },
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '退出登陆',
                        style: TextStyle(color: Colors.red, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
