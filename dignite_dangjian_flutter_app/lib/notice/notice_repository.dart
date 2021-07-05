import 'package:ran_flutter_core/config/net/http.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class NoticeRepository {
  /// 修改密码
  static Future changePassword(
      String currentPassword, String newPassword) async {
    var response = await http.post('/api/identity/my-profile/change-password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword});
    return response.statusCode;
  }


  static Future roles() async {
    var response = await http.get('/api/identity/roles');
    return response.statusCode;
  }


//  static Future addOrganizationUnit() async {
//    http.options.baseUrl = ConfigService.getApiUrl(key: "RanAccount");
//    var response = await http.post('/api/identity/organizationUnit', data: {
//      "displayName": "总党支部",
//      "isActive": true,
//      "roleIds": [
//        "0f70d8e6-81dc-e0f9-35a9-39fd44cb4cc7"
//      ],
//      "parentId": "6ea2f544-cb9b-ab54-906a-39fd5491a451"
//    });
//    return response.statusCode;
//  }
}
