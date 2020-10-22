import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';

import 'package:ran_flutter_account/account_repository.dart';
import 'package:ran_flutter_account/account_router.dart';
import 'package:ran_flutter_account/model/login_res_model.dart';
import 'package:ran_flutter_account/widgets/login_field_widget.dart';

import 'package:ran_flutter_account/widgets/third_component.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// outside new  inside dispose may be crash. watch it
  /// 理论上应该在当前页面dispose,
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pwdFocus = FocusNode();
  bool isBusy = false;

  @override
  void initState() {
    super.initState();
    var name = StorageManager.sharedPreferences.getString("userName");
    if (name != null) {
      _nameController.text = name;
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
        title: Text(
          '密码登录',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Color(0xFFF3F2F2),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Color(0xFFF3F2F2),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 30,
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
                    '${Environment.oAuthConfig['appName']}',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        ToastUtil.show('请联系管理员重置');
                        print('跳转到找回页面');
                      },
                      child: Text(
                        '忘记密码？',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
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
                          LoginRes loginRes = await AccountRepository.login(
                              _nameController.text, _passwordController.text);
                          StorageManager.sharedPreferences
                              .setString("accessToken", loginRes.accessToken);
                          StorageManager.sharedPreferences
                              .setString("userName", _nameController.text);
//                          NavigatorUtils.goBack(context);
////                          if()
                        NavigatorUtils.push(context, '/home',
                            clearStack: true, transition: TransitionType.inFromBottom);
                          setState(() {
                            isBusy = false;
                          });
                        } catch (e, s) {
                          print(e.toString());
                          getErrorTips(e, s, context: context);
                          setState(() {
                            isBusy = false;
                          });
                        }
                      },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '还没有账号，立即',
                    style: TextStyle(color: Colors.black45),
                  ),
                  InkWell(
                    onTap: () {
                      print('跳转到找回页面');
                      NavigatorUtils.pushResult(context, AccountRouter.register,
                          (name) => {this._nameController.text = name});
                    },
                    child: Text(
                      '注册',
                      style: TextStyle(color: color),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
              ThirdLogin()
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

/// LoginPage 按钮样式封装
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
          borderRadius: BorderRadius.circular(5),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}

//class SingUpWidget extends StatefulWidget {
//  final nameController;
//
//  SingUpWidget(this.nameController);
//
//  @override
//  _SingUpWidgetState createState() => _SingUpWidgetState();
//}
//
//class _SingUpWidgetState extends State<SingUpWidget> {
//  TapGestureRecognizer _recognizerRegister;
//
//  @override
//  void initState() {
//    _recognizerRegister = TapGestureRecognizer()
//      ..onTap = () async {
//        // 将注册成功的用户名,回填如登录框
//        widget.nameController.text =
//        await Navigator.of(context).pushNamed(RouteName.register);
//      };
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    _recognizerRegister.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Text.rich(TextSpan(text: S.of(context).noAccount, children: [
//        TextSpan(
//            text: S.of(context).toSignUp,
//            recognizer: _recognizerRegister,
//            style: TextStyle(color: Theme.of(context).accentColor))
//      ])),
//    );
//  }
//}
