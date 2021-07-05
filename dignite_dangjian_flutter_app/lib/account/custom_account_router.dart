import 'package:dignite_dangjian_flutter_app/account/page/login_page.dart';
import 'package:dignite_dangjian_flutter_app/account/page/register_page.dart';
import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';


class CustomAccountRouter implements IRouterProvider {
  static String accountPage = "/account";
  static String login = "/account/login";
  static String register = "/account/register";

  @override
  void initRouter(FluroRouter router) {
    router.define(login,
        handler: Handler(handlerFunc: (_, params) => LoginPage()));
    router.define(register,
        handler: Handler(handlerFunc: (_, params) => RegisterPage()));
  }
}
