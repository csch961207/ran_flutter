import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:limeauto/config/router_manger.dart';
import 'package:limeauto/generated/l10n.dart';
import 'package:limeauto/provider/provider_widget.dart';
import 'package:limeauto/ui/page/user/login_widget.dart';
import 'package:limeauto/ui/widget/button_progress_indicator.dart';
import 'package:limeauto/ui/widget/third_component.dart';
import 'package:limeauto/view_model/login_model.dart';

import 'package:provider/provider.dart';
import 'login_field_widget.dart';

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

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                LoginTopPanel(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
//                      LoginLogo(),
                      SizedBox(
                        height: 30,
                      ),
                      LoginFormContainer(
                          child:
//                          Text(''),
                          ProviderWidget<LoginModel>(
                            model: LoginModel(),
                            onModelReady: (model) {
                              _nameController.text = model.getLoginName();
                            },
                            builder: (context, model, child) {
                              return Form(
                                onWillPop: () async {
                                  return !model.isBusy;
                                },
                                child: child,
                              );
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  LoginTextField(
                                    label: S.of(context).userName,
                                    icon: Icons.perm_identity,
                                    controller: _nameController,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (text) {
                                      FocusScope.of(context)
                                          .requestFocus(_pwdFocus);
                                    },
                                  ),
                                  LoginTextField(
                                    controller: _passwordController,
                                    label: S.of(context).password,
                                    icon: Icons.lock_outline,
                                    obscureText: true,
                                    focusNode: _pwdFocus,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  LoginButton(_nameController, _passwordController),
                                  Text(
                                    '没有账号，请前往青橙汽车官网申请。',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  )
//                              SingUpWidget(_nameController),
                                ]),
                          )),
//                      ThirdLogin()
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
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
    var model = Provider.of<LoginModel>(context);
    return LoginButtonWidget(
      child: model.isBusy
          ? ButtonProgressIndicator()
          : Text(
        S.of(context).signIn,
        style: Theme.of(context)
            .accentTextTheme
            .title
            .copyWith(wordSpacing: 6),
      ),
      onPressed: model.isBusy
          ? null
          : () {
        var formState = Form.of(context);
        if (formState.validate()) {
          model
              .login(nameController.text, passwordController.text)
              .then((value) {
            if (value) {
              Navigator.of(context).pop(true);
              Navigator.of(context).pushReplacementNamed(RouteName.tab);
            } else {
              model.showErrorMessage(context);
            }
          });
        }
      },
    );
  }
}

class SingUpWidget extends StatefulWidget {
  final nameController;

  SingUpWidget(this.nameController);

  @override
  _SingUpWidgetState createState() => _SingUpWidgetState();
}

class _SingUpWidgetState extends State<SingUpWidget> {
  TapGestureRecognizer _recognizerRegister;

  @override
  void initState() {
    _recognizerRegister = TapGestureRecognizer()
      ..onTap = () async {
        // 将注册成功的用户名,回填如登录框
        widget.nameController.text =
        await Navigator.of(context).pushNamed(RouteName.register);
      };
    super.initState();
  }

  @override
  void dispose() {
    _recognizerRegister.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(text: S.of(context).noAccount, children: [
        TextSpan(
            text: S.of(context).toSignUp,
            recognizer: _recognizerRegister,
            style: TextStyle(color: Theme.of(context).accentColor))
      ])),
    );
  }
}
