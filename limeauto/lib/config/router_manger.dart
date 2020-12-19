import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:limeauto/ui/page/article/article_page.dart';
import 'package:limeauto/ui/page/article/comments_list.dart';
import 'package:limeauto/ui/page/blog_page.dart';
import 'package:limeauto/ui/page/coin/coin_record_list_page.dart';
import 'package:limeauto/ui/page/content_management_page.dart';
import 'package:limeauto/ui/page/home.dart';
import 'package:limeauto/ui/page/popular_page.dart';
import 'package:limeauto/ui/page/readingRecordList_page.dart';
import 'package:limeauto/ui/page/setting_page.dart';
import 'package:limeauto/ui/page/splash.dart';
import 'package:limeauto/ui/page/tab/tab_navigator.dart';
import 'package:limeauto/ui/page/user/login_page.dart';
import 'package:limeauto/ui/page/user/register_page.dart';
import 'package:limeauto/ui/widget/page_route_anim.dart';

class RouteName {
  static const String splash = 'splash';
  static const String tab = '/';
  static const String homeSecondFloor = 'homeSecondFloor';
  static const String login = 'login';
  static const String register = 'register';
  static const String articleDetail = 'articleDetail';
  static const String structureList = 'structureList';
  static const String favouriteList = 'favouriteList';
  static const String setting = 'setting';
  static const String coinRecordList = 'coinRecordList';
  static const String coinRankingList = 'coinRankingList';
  static const String contentManagement = 'contentManagement';
  static const String commentsList = 'commentsList';
  static const String blog = 'blog';
  static const String popular = 'popular';
  static const String readingRecordList = 'readingRecordList';
  static const String home = 'home';
}

class LimeAutoRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        return NoAnimRouteBuilder(TabNavigator());
      case RouteName.home:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => HomePage());
      case RouteName.login:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => LoginPage());
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => RegisterPage());
      case RouteName.articleDetail:
        var id = settings.arguments;
        return CupertinoPageRoute(builder: (_) => ArticlesPage(id:id));
      case RouteName.blog:
        var id = settings.arguments;
        return CupertinoPageRoute(builder: (_) => BlogPage(id:id));
      case RouteName.popular:
        var name = settings.arguments;
        return CupertinoPageRoute(builder: (_) => PopularPage(name:name));
      case RouteName.setting:
        return CupertinoPageRoute(builder: (_) => SettingPage());
      case RouteName.contentManagement:
        return CupertinoPageRoute(builder: (_) => ContentManagementPage());
      case RouteName.commentsList:
        var articles = settings.arguments;
        return CupertinoPageRoute(builder: (_) => CommentsListPage(articles));
      case RouteName.readingRecordList:
        return CupertinoPageRoute(builder: (_) => ReadingRecordListPage());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
