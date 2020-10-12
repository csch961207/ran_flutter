import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:junchengedmsflutterapp/config/routers/404.dart';
import 'package:junchengedmsflutterapp/config/routers/router_init.dart';
import 'package:junchengedmsflutterapp/enterprises/enterprises_router.dart';
import 'package:junchengedmsflutterapp/home/miniprogram_page.dart';
import 'package:junchengedmsflutterapp/home/tab_navigator.dart';
import 'package:junchengedmsflutterapp/home/webview_page.dart';
import 'package:junchengedmsflutterapp/login/login_router.dart';
import 'package:junchengedmsflutterapp/my/my_router.dart';
import 'package:junchengedmsflutterapp/setting/setting_router.dart';
import 'package:junchengedmsflutterapp/work/work_router.dart';

class Routes {
  static String home = "/home";
  static String webViewPage = "/webview";
  static String miniProgramPage = "/miniProgram";

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint("未找到目标页");
      return WidgetNotFound();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    TabNavigator()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));

    router.define(miniProgramPage, handler: Handler(handlerFunc: (_, params) {
      String url = params['url']?.first;
      return MiniProgramPage(url: url);
    }));

    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(EnterprisesRouter());
    _listRouter.add(WorkRouter());
    _listRouter.add(MyRouter());
    _listRouter.add(SettingRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
