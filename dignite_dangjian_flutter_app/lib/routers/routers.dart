import 'package:dignite_dangjian_flutter_app/account/custom_account_router.dart';
import 'package:dignite_dangjian_flutter_app/meeting/meeting_router.dart';
import 'package:dignite_dangjian_flutter_app/my/my_router.dart';
import 'package:dignite_dangjian_flutter_app/notice/notice_router.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/partyMember_router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:dignite_dangjian_flutter_app/routers/404.dart';
import 'package:dignite_dangjian_flutter_app/tab/tab_navigator.dart';
import 'package:ran_flutter_account/ran_flutter_account.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
//import 'package:ran_flutter_message/message_router.dart';
//import 'package:ran_flutter_site/ran_flutter_site.dart';

class Routes {
  static String home = "/home";
  static String webView = "/webview";

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

    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(CustomAccountRouter());
    _listRouter.add(AccountRouter());
    _listRouter.add(MyRouter());
    _listRouter.add(PartyMemberRouter());
    _listRouter.add(MeetingRouter());
    _listRouter.add(NoticeRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}