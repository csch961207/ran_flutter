import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/config/routers/router_init.dart';


class HomeRouter implements IRouterProvider {
  static String homePage = "/home";

  @override
  void initRouter(FluroRouter router) {
//    router.define(myPage,
//        handler: Handler(handlerFunc: (_, params) => MyPage()));
//    router.define(myAnsweredPetitionsDetailsPage, handler: Handler(handlerFunc: (_, params) {
//      String id = params['id']?.first;
//      return MyAnsweredPetitionsDetailsPage(id: id);
//    }));
  }
}
