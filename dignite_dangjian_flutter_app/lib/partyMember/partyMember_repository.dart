
import 'package:ran_flutter_core/config/net/http.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

import 'model/add_partyMembers_model.dart';
import 'model/partyMembers_list_model.dart';
import 'model/partyMembers_model.dart';

class PartyMemberRepository {

  /// 获取党员列表
  static Future<PartyMemberList> getPartyMemberList({String organizationUnitId, bool isDeparted, bool isAudited, bool isUploadFace, String filter,
      int maxResultCount, int skipCount}) async {
    Map<String, String> params = Map();
    params["OrganizationUnitId"] = organizationUnitId;
    if(isDeparted != null){
      params["isDeparted"] = isDeparted.toString();
    }
    if(isAudited != null){
      params["isAudited"] = isAudited.toString();
    }
    if(isUploadFace != null){
      params["isUploadFace"] = isUploadFace.toString();
    }
    if(filter != null){
      params["filter"] = filter;
    }
    if(maxResultCount != null){
      params["MaxResultCount"] = maxResultCount.toString();
    } else {
      params["MaxResultCount"] = "1000";
    }
    if(skipCount != null){
      params["SkipCount"] = skipCount.toString();
    }
    var response = await http.get('/api/Dangjian/PartyMembers',
        queryParameters: params);
    return PartyMemberList.fromJson(response.data);
  }

  /// 删除党员
  static Future<String> deletePartyMember(String userId) async {
    Map<String, String> params = Map();
    params["userId"] = userId;
    var response = await http.delete('/api/Dangjian/PartyMembers',queryParameters: params);
    return response.statusCode.toString();
  }

  /// 添加党员
  static Future<String> postPartyMembers(AddPartyMember addPartyMemberData) async {
    print(http.options.headers);
    print("打印");
    var response =
    await http.post('/api/Dangjian/PartyMembers', data: addPartyMemberData);
    return response.statusCode.toString();
  }

  /// 编辑党员
  static Future<String> putPartyMembers(String id, PartyMemberEdit partyMemberEdit) async {
    Map<String, String> params = Map();
    params["id"] = id;
    var response =
    await http.put('/api/Dangjian/PartyMembers', data: partyMemberEdit, queryParameters: params);
    return response.statusCode.toString();
  }

  /// 获取党员详细信息
  static Future<PartyMember> getPartyMembers(String id) async {
    var response = await http.get(
      '/api/Dangjian/PartyMembers/${id}',
    );
    return PartyMember.fromJson(response.data);
  }

  /// 添加党员人脸图像
  static Future<String> postAddFace(String userId, String filePath) async {
    var name = filePath.substring(filePath.lastIndexOf("/") + 1);
    var fromFile = await MultipartFile.fromFile(filePath, filename: name);
    FormData formData = FormData.fromMap({
      "file": fromFile
    });
    var response =
    await http.post('/api/Dangjian/PartyMembers/AddFaceByFile', data: formData,queryParameters: {"userId":userId});
    return response.statusCode.toString();
  }

  /// 导入
  static Future<String> postImport(String organizationUnitId, String blobName) async {
    var response =
    await http.post('/api/Dangjian/PartyMembers/import', queryParameters: {"organizationUnitId":organizationUnitId,"blobName":blobName});
    return response.statusCode.toString();
  }
}
