import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/routers/routers.dart';
import 'package:flutter_app/splash/splash_page.dart';
import 'package:flutter_app/view_model/locale_model.dart';
import 'package:flutter_app/view_model/theme_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.setApis({
    "default": "http://juncheng.edms.ran.xyz",
    "AbpIdentity": "http://juncheng.edms.ran.xyz",
    "RanSite": "http://juncheng.edms.ran.xyz"
  });
  Environment.setOAuthConfig({
    "clientId": 'Edms_App',
    "dummyClientSecret": '1q2w3e*',
    "scope": 'Edms',
  });
  Provider.debugCheckInvalidValueType = null;
  await StorageManager.init();
  runApp(App());
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

class App extends StatelessWidget {
  final Widget home;
  App({this.home}) {
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
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
//                      initialRoute: RouteName.tab,
                ),
              );
            })));
  }
}
