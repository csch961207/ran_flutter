import 'package:dignite_dangjian_flutter_app/my/page/my_info.dart';
import 'package:dignite_dangjian_flutter_app/my/page/my_page.dart';
import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

import 'page/set_page.dart';

class MyRouter implements IRouterProvider {
  static String myPage = "/my";
  static String setPage = "/setPage";
  static String myInfoPage = "/myInfoPage";

  @override
  void initRouter(FluroRouter router) {
    router.define(myPage,
        handler: Handler(handlerFunc: (_, params) => MyPage()));
    router.define(setPage,
        handler: Handler(handlerFunc: (_, params) => SetPage()));
    router.define(myInfoPage,
        handler: Handler(handlerFunc: (_, params) => MyInfoPage()));
//    router.define(myAnsweredPetitionsDetailsPage, handler: Handler(handlerFunc: (_, params) {
//      String id = params['id']?.first;
//      return MyAnsweredPetitionsDetailsPage(id: id);
//    }));
  }
}
