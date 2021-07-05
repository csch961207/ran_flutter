import 'package:dignite_dangjian_flutter_app/tab/tab_navigator.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dignite_dangjian_flutter_app/generated/l10n.dart';
import 'package:dignite_dangjian_flutter_app/routers/routers.dart';
import 'package:dignite_dangjian_flutter_app/view_model/locale_model.dart';
import 'package:dignite_dangjian_flutter_app/view_model/theme_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:bot_toast/bot_toast.dart';

import 'splash/splash_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  判断当前环境，当App是Release环境的时候inProduction为true
  const bool inProduction = Constant.inProduction;
  Environment.setApis({
      "default": "http://192.168.1.133:44392",
      "RanAccount": "http://192.168.1.133:44351",
  });
  Environment.setOAuthConfig({
    "appName": '红色e会通',
    "clientId": 'Dangjian_App',
    "clientSecret": '1q2w3e*',
    "scope": 'Dangjian',
  });

  Provider.debugCheckInvalidValueType = null;
  await StorageManager.init();
  runApp(App());
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  ///设置加载点击背景不自动关闭
  EasyLoading.instance.dismissOnTap = false;
  /// 设置当loading展示的时候，不允许用户操作
  EasyLoading.instance.userInteractions = false;
}

class App extends StatelessWidget {
  final Widget home;
  App({this.home}) {
    final FluroRouter router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
            providers: [
          ChangeNotifierProvider<CoreViewModel>(
            create: (context) => CoreViewModel(),
          ),
          ChangeNotifierProvider<ThemeModel>(
            create: (context) => ThemeModel(),
          ),
          ChangeNotifierProvider<LocaleModel>(
            create: (context) => LocaleModel(),
          ),
          ChangeNotifierProvider<DangjianViewModel>(
            create: (context) => DangjianViewModel(),
          ),
//          ChangeNotifierProvider<MessageModel>(
//            create: (context) => MessageModel(),
//          ),
        ],
            child: Consumer4<ThemeModel, LocaleModel, CoreViewModel,DangjianViewModel>(builder:
                (context, themeModel, localeModel, coreViewModel,dangjianViewModel, child) {
              final botToastBuilder = BotToastInit(); //1.调用BotToastInit
              return RefreshConfiguration(
                hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: themeModel.themeData(),
                  darkTheme: themeModel.themeData(platformDarkMode: true),
                  locale: localeModel.locale,
                  localizationsDelegates: const [
                    S.delegate,
                    RefreshLocalizations.delegate, //下拉刷新
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  home: home ?? SplashPage(),
                  onGenerateRoute: Application.router.generator,
                  builder: (BuildContext context, Widget child) {
                    /// make sure that loading can be displayed in front of all other widgets
                    child = FlutterEasyLoading(child: child);
                    child = botToastBuilder(context, child);
                    return child;
                  },
                  navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
                ),
              );
            })));
  }
}
