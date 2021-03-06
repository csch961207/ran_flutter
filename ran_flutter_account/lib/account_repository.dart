import 'package:ran_flutter_account/account_api.dart';
import 'package:ran_flutter_account/model/login_res_model.dart';
import 'package:ran_flutter_account/model/my_profile_model.dart';
import 'package:ran_flutter_account/model/register_res_model.dart';
import 'package:ran_flutter_account/model/user_model.dart';
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
      "client_secret": Environment.oAuthConfig['clientSecret']
    });
    var response =
        await accountHttp.post<Map>('/connect/token', data:
          'grant_type=password&scope=${Environment.oAuthConfig['scope']}&username=${username}&password=${password}&client_id=${Environment.oAuthConfig['clientId']}&client_secret=${Environment.oAuthConfig['clientSecret']}',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    return LoginRes.fromJson(response.data);
  }

  /// 注册
  static Future register(
      String username, String password, String emailAddress) async {
    var response = await accountHttp.post<Map>('/api/account/register', data: {
      'userName': username,
      'password': password,
      'emailAddress': emailAddress,
      'appName': Environment.oAuthConfig['clientId']
    });
    return RegisterRes.fromJson(response.data);
  }

  /// 获取个人资料
  static Future<MyProfile> getMyProfile() async {
    var response = await accountHttp.get(
      '/api/identity/my-profile',
    );
    return MyProfile.fromJson(response.data);
  }

  /// 修改个人资料
  static Future editMyProfile(InputMyProfile inputMyProfile) async {
    var response =
        await accountHttp.put('/api/identity/my-profile', data: inputMyProfile);
    return response.statusCode;
  }

  /// 修改密码
  static Future changePassword(
      String currentPassword, String newPassword) async {
    var response = await accountHttp.post(
        '/api/identity/my-profile/change-password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword});
    return response.statusCode;
  }

//  /// 获取用户资料
//  static Future<User> getUser(String id) async {
//    var response = await accountHttp.get(
//      '/api/identity/users/lookup/${id}',
//    );
//    return User.fromJson(response.data);
//  }
}
