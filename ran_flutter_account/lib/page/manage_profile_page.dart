import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ran_flutter_account/account_repository.dart';
import 'package:ran_flutter_account/account_router.dart';
import 'package:ran_flutter_account/model/my_profile_model.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ManageProfilePage extends StatefulWidget {
  @override
  _ManageProfilePageState createState() => _ManageProfilePageState();
}

class _ManageProfilePageState extends State<ManageProfilePage> {
  @override
  void initState() {
    super.initState();
    getMyProfile();
  }

  MyProfile _myProfile = new MyProfile();

  getMyProfile() async {
    EasyLoading.show();
    try {
      MyProfile myProfile = await AccountRepository.getMyProfile();
      setState(() {
        _myProfile = myProfile;
      });
//      print(_myProfile);
      EasyLoading.dismiss();
    } catch (e, s) {
      print(e.toString());
      EasyLoading.dismiss();
      getErrorTips(e, s, context: context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '个人资料',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Color(0xFFF3F2F2),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ClickItem(
                              title: "用户名",
                              content: _myProfile?.userName ?? '',
                              onTap: () {
                                try {
                                  Clipboard.setData(ClipboardData(
                                      text: _myProfile?.userName ?? ''));
                                  ToastUtil.show('复制成功');
                                } catch (e) {
                                  print(e);
                                  ToastUtil.show('复制失败');
                                }
                              },
                            ),
                            ClickItem(
                              title: "昵称",
                              content: _myProfile?.name ?? '',
                              onTap: () {
                                try {
                                  Clipboard.setData(ClipboardData(
                                      text: _myProfile?.name ?? ''));
                                  ToastUtil.show('复制成功');
                                } catch (e) {
                                  print(e);
                                  ToastUtil.show('复制失败');
                                }
                              },
                            ),
                            ClickItem(
                              title: "电子邮箱",
                              content: _myProfile?.email ?? '',
                              onTap: () {
                                try {
                                  Clipboard.setData(ClipboardData(
                                      text: _myProfile?.email ?? ''));
                                  ToastUtil.show('复制成功');
                                } catch (e) {
                                  print(e);
                                  ToastUtil.show('复制失败');
                                }
                              },
                            ),
//                            ClickItem(
//                              title: "姓",
//                              content: _myProfile?.surname ?? '',
//                              onTap: () {},
//                            ),
//                            ClickItem(
//                              title: "名",
//                              content: _myProfile?.name ?? '',
//                              onTap: () {},
//                            ),
                            ClickItem(
                              title: "手机号",
                              content: _myProfile?.phoneNumber ?? '',
                              onTap: () {
                                try {
                                  Clipboard.setData(ClipboardData(
                                      text: _myProfile?.phoneNumber ?? ''));
                                  ToastUtil.show('复制成功');
                                } catch (e) {
                                  print(e);
                                  ToastUtil.show('复制失败');
                                }
                              },
                            ),
                            ClickItem(
                              title: "我的二维码",
                              widgetContent: Icon(Icons.qr_code),
                              onTap: () {
                                NavigatorUtils.push(
                                    context, AccountRouter.myQrPage);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
              child: RanButton(
                text: '编辑资料',
//                isShape: true,
                onPressed: () async {
                  NavigatorUtils.pushResult(
                      context,
                      AccountRouter.editProfilePage,
                      (result) => {getMyProfile()});
                },
              ),
            ),
          ]),
    );
  }
}
