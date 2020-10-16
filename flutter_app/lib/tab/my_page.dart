import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/view_model/theme_model.dart';
import 'package:ran_flutter_account/ran_flutter_account.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

//  Enterprises enterprises;
//
//  getEnterprises() async {
//    try {
//      Enterprises res = await EnterprisesRepository.fetchEnterprises(1);
//      setState(() {
//        enterprises = res;
//      });
//    } catch (e, s) {
//      print(e.toString());
//      getErrorTips(e, s, context: context);
//    }
//  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            InkWell(
              onTap: () {
                NavigatorUtils.push(context, AccountRouter.login,
                    transition: TransitionType.cupertino);
              },
              child: Text("我的"),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                NavigatorUtils.push(context, AccountRouter.updatePassword,
                    transition: TransitionType.cupertino);
              },
              child: Text("修改密码"),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("黑暗模式"),
                CupertinoSwitch(
                    activeColor: Theme.of(context).accentColor,
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) {
                      switchDarkMode(context);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  void switchDarkMode(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      ToastUtil.show("检测到系统为暗黑模式,已为你自动切换");
//      showToast("检测到系统为暗黑模式,已为你自动切换",position: ToastPosition.bottom);
    } else {
      Provider.of<ThemeModel>(context, listen: false).switchTheme(
          userDarkMode: Theme.of(context).brightness == Brightness.light);
    }
  }
}
