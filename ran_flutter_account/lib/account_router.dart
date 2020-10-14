import 'package:fluro/fluro.dart';
import 'package:ran_flutter_account/page/login_page.dart';
import 'package:ran_flutter_account/page/update_password_page.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class AccountRouter implements IRouterProvider {
  static String accountPage = "/account";
  static String login = "/account/login";
  static String register = "/account/register";
  static String manageProfile = "/account/manageProfile";
  static String updatePasswordPage = "/account/updatePasswordPage";

  @override
  void initRouter(Router router) {
    router.define(login,
        handler: Handler(handlerFunc: (_, params) => LoginPage()));
    router.define(updatePasswordPage,
        handler: Handler(handlerFunc: (_, params) => UpdatePasswordPage()));
  }
}
