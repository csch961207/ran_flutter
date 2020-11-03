import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';

import 'package:provider/provider.dart';
import 'package:ran_flutter_account/account_repository.dart';
import 'package:ran_flutter_account/model/login_res_model.dart';
import 'package:ran_flutter_account/model/register_res_model.dart';
import 'package:ran_flutter_account/widgets/login_field_widget.dart';

import 'package:ran_flutter_account/widgets/third_component.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// outside new  inside dispose may be crash. watch it
  /// 理论上应该在当前页面dispose,
  final _nameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pwdFocus = FocusNode();
  bool isBusy = false;
  bool isAgree = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailAddressController.dispose();
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
          '账号注册',
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
                  label: '邮箱账号',
                  icon: Icons.alternate_email,
                  controller: _emailAddressController,
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
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAgree = !isAgree;
                        });
                      },
                      child: Image.asset(
                        isAgree
                            ? 'packages/ran_flutter_account/' +
                                ImageHelper.wrapAssets('xz.png')
                            : 'packages/ran_flutter_account/' +
                                ImageHelper.wrapAssets('xztm.png'),
                        width: 15,
                        height: 15,
                        fit: BoxFit.fitWidth,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '我已阅读并同意',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    InkWell(
                      onTap: () {
                        NavigatorUtils.goWebViewPage(context,
                            'https://www.apple.com.cn/legal/internet-services/terms/site.html');
                      },
                      child: Text(
                        '《用户许可协议》 ',
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        NavigatorUtils.goWebViewPage(context,
                            'http://lyjdxx.cn/admin/site/index.html');
                      },
                      child: Text(
                        ' 《隐私政策》',
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              LoginButtonWidget(
                child: isBusy
                    ? ButtonProgressIndicator()
                    : Text(
                        '注册',
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
                        String emailAddress = _emailAddressController.text;
                        if (name.isEmpty) {
                          ToastUtil.show('请输入用户名');
                          return;
                        }
                        if (emailAddress.isEmpty) {
                          ToastUtil.show('请输入邮箱账号');
                          return;
                        }
                        if (password.isEmpty) {
                          ToastUtil.show('请输入密码');
                          return;
                        }
                        if (!isAgree) {
                          ToastUtil.show('请先同意用户协议');
                          return;
                        }
                        setState(() {
                          isBusy = true;
                        });
                        try {
                          RegisterRes registerRes =
                              await AccountRepository.register(
                                  _nameController.text,
                                  _passwordController.text,
                                  _emailAddressController.text);
                          NavigatorUtils.goBackWithParams(
                              context, registerRes.userName);
//                        NavigatorUtils.push(context, 'home',
//                            clearStack: true, transition: TransitionType.inFromBottom);
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
              '注册',
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
