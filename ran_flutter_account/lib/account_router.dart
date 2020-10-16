import 'package:fluro/fluro.dart';
import 'package:ran_flutter_account/page/login_page.dart';
import 'package:ran_flutter_account/page/register_page.dart';
import 'package:ran_flutter_account/page/update_password_page.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class AccountRouter implements IRouterProvider {
  static String accountPage = "/account";
  static String login = "/account/login";
  static String register = "/account/register";
  static String manageProfile = "/account/manageProfile";
  static String updatePassword = "/account/updatePassword";

  @override
  void initRouter(FluroRouter router) {
    router.define(login,
        handler: Handler(handlerFunc: (_, params) => LoginPage()));
    router.define(register,
        handler: Handler(handlerFunc: (_, params) => RegisterPage()));
    router.define(updatePassword,
        handler: Handler(handlerFunc: (_, params) => UpdatePasswordPage()));
  }
}
