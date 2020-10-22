import 'package:flutter/material.dart';
import 'package:ran_flutter_account/account_repository.dart';
import 'package:ran_flutter_account/account_router.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluro/fluro.dart';

class UpdatePasswordPage extends StatefulWidget {
  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  //定义一个controller
  TextEditingController _oldPwdController = TextEditingController();
  TextEditingController _newPwdController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("重置登录密码"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap8,
            TextFieldItem(
              controller: _oldPwdController,
              title: "旧密码:",
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: "请输入旧密码",
            ),
            Gaps.vGap8,
            TextFieldItem(
              controller: _newPwdController,
              title: "新密码:",
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: "请输入新密码",
            ),
            Gaps.vGap8,
            TextFieldItem(
              controller: _confirmPwdController,
              title: "确认密码:",
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: "请输入确认新密码",
            ),
            Gaps.vGap10,
            Gaps.vGap15,
            MyButton(
              onPressed: () async {
                if (_oldPwdController.text == null ||
                    _oldPwdController.text == '') {
                  Toast.show('请输入旧密码');
                  return;
                }
                if (_newPwdController.text == null ||
                    _newPwdController.text == '') {
                  Toast.show('请输入新密码');
                  return;
                }
                if (_confirmPwdController.text == null ||
                    _confirmPwdController.text == '') {
                  Toast.show('请输入确认密码');
                  return;
                }
                if (_newPwdController.text != _confirmPwdController.text) {
                  Toast.show('两次输入不一致');
                  return;
                }
                EasyLoading.show(status: '加载中...');
                try {
                  var value = await AccountRepository.changePassword(
                      _oldPwdController.text, _newPwdController.text);
                  if (value == 200 || value == 204) {
                    Toast.show('修改成功,请重新登陆');
                    StorageManager.sharedPreferences
                        .setString("accessToken", '');
                    NavigatorUtils.goBack(context);
                    NavigatorUtils.push(context, AccountRouter.login,
                        transition: TransitionType.inFromBottom);
                  } else {
                    Toast.show('修改失败');
                  }
                  EasyLoading.dismiss();
                } catch (e, s) {
                  EasyLoading.dismiss();
                  print(e.toString());
                  getErrorTips(e, s, context: context);
                }
              },
              text: "确认",
            )
          ],
        ),
      ),
    );
  }
}
