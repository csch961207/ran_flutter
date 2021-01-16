import 'dart:io';
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'account/sign_in_page.dart';
import 'config/routers/application.dart';
import 'config/storage_manager.dart';
import 'db/sql_manager.dart';
import 'generated/l10n.dart';
import 'routers/routers.dart';
import 'tab/tab_navigator.dart';
import 'view_model/locale_model.dart';
import 'view_model/theme_model.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  await AmapLocation.instance.init(iosKey: '5542294979c2fe370d4802c9c1906b88');

  Provider.debugCheckInvalidValueType = null;

  EasyLoading.instance..maskType = EasyLoadingMaskType.clear;
  await SqlManager.init();
  runApp(App());
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeModel>(
            create: (context) => ThemeModel(),
          ),
          ChangeNotifierProvider<LocaleModel>(
            create: (context) => LocaleModel(),
          ),
        ],
        child: Consumer2<ThemeModel, LocaleModel>(
            builder: (context, themeModel, localeModel, child) {
          final botToastBuilder = BotToastInit(); //1.调用BotToastInit
          return RefreshConfiguration(
            hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
            child: MaterialApp(
              title: '终端营销检查',
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
              home: home ?? SignInPage(),
              onGenerateRoute: Application.router.generator,
              builder: (BuildContext context, Widget child) {
                /// make sure that loading can be displayed in front of all other widgets
                child = FlutterEasyLoading(
                  child: child,
                );
                child = botToastBuilder(context, child);
                return child;
              },
              navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
            ),
          );
        }));
  }
}
