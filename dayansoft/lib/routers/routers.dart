import 'package:dayansoft/event/event_router.dart';

import '../account/account_router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../page/webview_page.dart';
import '../tab/tab_navigator.dart';
import '../config/routers/router_init.dart';
import '404.dart';

class Routes {
  static String home = "/home";
  static String webView = "/webview";
//  static String scan = "/scan";

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(FluroRouter router) {
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

    router.define(webView, handler: Handler(handlerFunc: (_, params) {
      String url = params['url']?.first;
      return WebViewPage(url: url);
    }));

//    router.define(scan,
//        handler: Handler(
//            handlerFunc:
//                (BuildContext context, Map<String, List<String>> params) =>
//                    ScanPage()));

    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(AccountRouter());
    _listRouter.add(EventRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
