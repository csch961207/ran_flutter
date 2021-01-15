import 'dart:convert';

import 'package:dayansoft/model/user.dart';
import 'package:dayansoft/service/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';
import '../config/resource_mananger.dart';
import '../config/routers/fluro_navigator.dart';
import '../config/storage_manager.dart';
import '../utils/toast_util.dart';
import '../widget/button_progress_indicator.dart';
import '../widget/login_field_widget.dart';

import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  /// outside new  inside dispose may be crash. watch it
  /// 理论上应该在当前页面dispose,
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pwdFocus = FocusNode();
  bool isBusy = false;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    var name = StorageManager.sharedPreferences.getString("userName");
    var password = StorageManager.sharedPreferences.getString("password");
    var rememberMeBool = StorageManager.sharedPreferences.getBool("rememberMe");
    if (name != null) {
      _nameController.text = name;
    }
    if (password != null) {
      _passwordController.text = password;
    }
    if (rememberMeBool != null) {
      rememberMe = rememberMeBool;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _pwdFocus.unfocus();
    _pwdFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
//        title: Text(
//          '密码登录',
//          style: TextStyle(color: Colors.black87),
//        ),
        backgroundColor: Color(0xFFF3F2F2),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Color(0xFFF3F2F2),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 50,
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
                    '终端营销检查',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                child: LoginTextField(
                  label: '用户名',
                  icon: Icons.perm_identity,
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) {
                    FocusScope.of(context).requestFocus(_pwdFocus);
                  },
                ),
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                child: LoginTextField(
                  controller: _passwordController,
                  label: '密码',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  focusNode: _pwdFocus,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: 25, right: 20, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rememberMe = !rememberMe;
                          });
                          StorageManager.sharedPreferences
                              .setBool("rememberMe", rememberMe);
                        },
                        child: rememberMe
                            ? Icon(
                                CupertinoIcons.check_mark_circled_solid,
                                color: color,
                                size: 20,
                              )
                            : Icon(
                                CupertinoIcons.circle,
                                color: color,
                                size: 20,
                              ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '记住密码',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      )
                    ],
                  )),
              LoginButtonWidget(
                child: isBusy
                    ? ButtonProgressIndicator()
                    : Text(
                        '登陆',
                        style: Theme.of(context)
                            .accentTextTheme
                            .title
                            .copyWith(wordSpacing: 6),
                      ),
                onPressed: isBusy
                    ? null
                    : () async {
                        String name = _nameController.text;
                        String password = _passwordController.text;
                        if (name.isEmpty) {
                          ToastUtil.show('请输入用户名');
                          return;
                        }
                        if (password.isEmpty) {
                          ToastUtil.show('请输入密码');
                          return;
                        }
                        setState(() {
                          isBusy = true;
                        });
                        try {
                          StorageManager.sharedPreferences
                              .setString("userName", _nameController.text);
                          StorageManager.sharedPreferences
                              .setString("password", _passwordController.text);
                          User user = await AppRepository.login(
                              _nameController.text, _passwordController.text);
                          StorageManager.sharedPreferences
                              .setString("user", json.encode(user));
                          setState(() {
                            isBusy = false;
                          });
                          NavigatorUtils.push(context, '/home',
                              replace: true,
                              clearStack: true,
                              transition: TransitionType.inFromBottom);
                        } catch (e, s) {
                          print(e.toString());
                          setState(() {
                            isBusy = false;
                          });
                        }
                      },
              ),
              SizedBox(
                height: 10,
              ),
            ]),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    bool isBusy = false;
    return LoginButtonWidget(
      child: isBusy
          ? ButtonProgressIndicator()
          : Text(
              '登陆',
              style: Theme.of(context)
                  .accentTextTheme
                  .title
                  .copyWith(wordSpacing: 6),
            ),
      onPressed: isBusy
          ? null
          : () {
              var formState = Form.of(context);
              if (formState.validate()) {}
            },
    );
  }
}

/// SignInPage 按钮样式封装
class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(20),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}
