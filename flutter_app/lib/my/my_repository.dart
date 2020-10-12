
import 'package:ran_flutter_core/config/net/http.dart';

class MyRepository {
  /// 修改密码
  static Future changePassword(
      String currentPassword, String newPassword) async {
    var response = await http.post('/api/identity/my-profile/change-password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword});
    return response.statusCode;
  }
}
