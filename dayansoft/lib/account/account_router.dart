import 'package:fluro/fluro.dart';

import '../config/routers/router_init.dart';
import 'sign_in_page.dart';

class AccountRouter implements IRouterProvider {
  static String signInPage = "/account/signInPage";

  @override
  void initRouter(FluroRouter router) {
    router.define(signInPage,
        handler: Handler(handlerFunc: (_, params) => SignInPage()));
  }
}
