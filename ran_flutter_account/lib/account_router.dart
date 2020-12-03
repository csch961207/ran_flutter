import 'package:fluro/fluro.dart';
import 'package:ran_flutter_account/page/edit_profile_page.dart';
import 'package:ran_flutter_account/page/login_page.dart';
import 'package:ran_flutter_account/page/manage_profile_page.dart';
import 'package:ran_flutter_account/page/my_qr_page.dart';
import 'package:ran_flutter_account/page/register_page.dart';
import 'package:ran_flutter_account/page/update_password_page.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class AccountRouter implements IRouterProvider {
  static String accountPage = "/account";
  static String login = "/account/login";
  static String register = "/account/register";
  static String manageProfile = "/account/manageProfile";
  static String updatePassword = "/account/updatePassword";
  static String editProfilePage = "/account/editProfilePage";
  static String myQrPage = "/account/myQrPage";

  @override
  void initRouter(FluroRouter router) {
    router.define(login,
        handler: Handler(handlerFunc: (_, params) => LoginPage()));
    router.define(register,
        handler: Handler(handlerFunc: (_, params) => RegisterPage()));
    router.define(manageProfile,
        handler: Handler(handlerFunc: (_, params) => ManageProfilePage()));
    router.define(editProfilePage,
        handler: Handler(handlerFunc: (_, params) => EditProfilePage()));
    router.define(updatePassword,
        handler: Handler(handlerFunc: (_, params) => UpdatePasswordPage()));
    router.define(myQrPage,
        handler: Handler(handlerFunc: (_, params) => MyQrPage()));
  }
}
