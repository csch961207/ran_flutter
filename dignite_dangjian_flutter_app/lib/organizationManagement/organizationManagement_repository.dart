

import 'package:ran_flutter_core/ran_flutter_core.dart';

import 'model/my_organization.dart';
import 'model/register_model.dart';

class OrganizationManagementRepository {

  /// 管理员注册
  static Future<String> postRegister(Register register) async {
    var response =
    await http.post('/api/Dangjian/OrganizationManagement/Register', data: register);
    return response.statusCode.toString();
  }
  /// 获取我的党组织信息
  static Future<MyOrganization> getMyOrganization() async {
    var response = await http.get(
      '/api/Dangjian/OrganizationManagement/My',
    );
    return MyOrganization.fromJson(response.data);
  }
}