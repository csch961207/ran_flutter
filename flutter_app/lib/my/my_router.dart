import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class MyRouter implements IRouterProvider {
  static String myPage = "/my";

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
