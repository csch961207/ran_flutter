import 'package:ran_flutter_account/account_api.dart';
import 'package:ran_flutter_account/model/login_res_model.dart';
import 'package:ran_flutter_account/model/register_res_model.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class AccountRepository {
  /// 账号密码登录
  static Future login(String username, String password) async {
    FormData formData = new FormData.fromMap({
      "grant_type": "password",
      "scope": Environment.oAuthConfig['scope'],
      "username": username,
      "password": password,
      "client_id": Environment.oAuthConfig['clientId'],
      "client_secret": Environment.oAuthConfig['dummyClientSecret']
    });
    var response =
        await accountHttp.post<Map>('/connect/token', data: formData);
    return LoginRes.fromJson(response.data);
  }

  /// 注册
  static Future register(
      String username, String password, String emailAddress) async {
    var response = await http.post<Map>('/api/account/register', data: {
      'userName': username,
      'password': password,
      'emailAddress': emailAddress,
      'appName': Environment.oAuthConfig['clientId']
    });
    return RegisterRes.fromJson(response.data);
  }

  /// 修改密码
  static Future changePassword(
      String currentPassword, String newPassword) async {
    var response = await accountHttp.post(
        '/api/identity/my-profile/change-password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword});
    return response.statusCode;
  }
}
