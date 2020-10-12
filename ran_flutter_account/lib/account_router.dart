import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class AccountRouter implements IRouterProvider {
  static String accountPage = "/account";
  static String login = "/account/login";
  static String register = "/account/register";
  static String manageProfile = "/account/manageProfile";

  @override
  void initRouter(Router router) {
//    router.define(myPage,
//        handler: Handler(handlerFunc: (_, params) => MyPage()));
//    router.define(myAnsweredPetitionsDetailsPage, handler: Handler(handlerFunc: (_, params) {
//      String id = params['id']?.first;
//      return MyAnsweredPetitionsDetailsPage(id: id);
//    }));
  }
}
