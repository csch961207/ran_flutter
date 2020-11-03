import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/routers/routers.dart';
import 'package:flutter_app/splash/splash_page.dart';
import 'package:flutter_app/view_model/locale_model.dart';
import 'package:flutter_app/view_model/theme_model.dart';
import 'package:flutter_app/widget/light_switch/light_switch_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_fields/ran_flutter_fields.dart';
import 'package:ran_flutter_message/message_provider.dart';
import 'package:ran_flutter_message/view_model/message_model.dart';
import 'package:ran_flutter_site/parse_field_provider.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:ran_flutter_site/ran_flutter_site.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  判断当前环境，当App是Release环境的时候inProduction为true
  const bool inProduction = Constant.inProduction;
  Environment.setApis({
//    "default": "http://juncheng.edms.ran.xyz",
//    "AbpIdentity": "http://juncheng.edms.ran.xyz",
    "default": "http://ld.ynxf.gov.cn:8012",
//    "default": "https://zouping.liudongdangyuan.ran.xyz"
  });
//  Environment.setOAuthConfig({
//    "appName": '君成环保',
//    "clientId": 'Edms_App',
//    "dummyClientSecret": '1q2w3e*',
//    "scope": 'Edms',
//  });
  Environment.setOAuthConfig({
    "appName": '沂南流动党员e家',
    "clientId": 'Zuzhibu_App',
    "dummyClientSecret": '1q2w3e*',
    "scope": 'Zuzhibu',
  });
//  Environment.setOAuthConfig({
//    "appName": '邹平流动党员e家',
//    "clientId": 'Liudongdangyuan_App',
//    "dummyClientSecret": '1q2w3e*',
//    "scope": 'Liudongdangyuan',
//  });
  FieldTypeProvider.init();
  FieldTypeProviderModel fieldTypeProvider = new FieldTypeProviderModel(
      fieldTypeName: 'LightSwitch', fieldTypeWidget: getNewLightSwitchBuild);
  FieldTypeProvider.addFieldTypeProviderModel([fieldTypeProvider]);

  ParseFieldProvider.init();
  MessageProvider.init();

  Provider.debugCheckInvalidValueType = null;
  await StorageManager.init();
  runApp(App());
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
          ChangeNotifierProvider<SectionsViewModel>(
            create: (context) => SectionsViewModel(),
          ),
          ChangeNotifierProvider<MessageModel>(
            create: (context) => MessageModel(),
          ),
        ],
            child: Consumer3<ThemeModel, LocaleModel, CoreViewModel>(builder:
                (context, themeModel, localeModel, coreViewModel, child) {
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
