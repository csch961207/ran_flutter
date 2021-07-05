import 'model/organizationUnit_list_model.dart';
import 'organizationUnit_api.dart';

class OrganizationUnitRepository {
  /// 获取党组织
  static Future<OrganizationUnitList> getOrganizationUnitList({String filter}) async {
    Map<String, String> params = Map();
    params["filter"] = filter;
    var response = await organizationUnitHttp.get(
      '/api/identity/organizationUnit',
    );
    return OrganizationUnitList.fromJson(response.data);
  }
  /// 根据父级获取党组织
  static Future<OrganizationUnitList> getOrganizationUnitListByChildren(String parentId,bool recursive) async {
    Map<String, String> params = Map();
    params["parentId"] = parentId;
    params["recursive"] = recursive.toString();
    var response = await organizationUnitHttp.get(
      '/api/identity/organizationUnit/children',queryParameters: params
    );
    return OrganizationUnitList.fromJson(response.data);
  }
}