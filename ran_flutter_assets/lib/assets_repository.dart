import 'package:ran_flutter_assets/assets_api.dart';
import 'package:ran_flutter_assets/model/file_model.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class AssetsRepository {
  /// 根据folderToken和providerKey上传文件
  static Future upload(
      File file, String providerKey, String folderToken) async {
    String path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1);
    var fromFile = await MultipartFile.fromFile(path, filename: name);
    FormData formData = FormData.fromMap({
      "file": fromFile,
      "providerKey": providerKey,
      "folderToken": folderToken
    });
    var response =
        await assetsHttp.post('/api/assets/files/upload', data: formData);
    return response.statusCode;
  }

  /// 根据文件夹id查看文件列表
  static Future fetchFileList(String providerKey, String folerId,
      int maxResultCount, int skipCount) async {
    Map<String, String> params = Map();
    params["providerKey"] = providerKey;
    params["MaxResultCount"] = maxResultCount.toString();
    params["SkipCount"] = skipCount.toString();
    var response = await http.get('/api/assets/files/' + folerId + '/list',
        queryParameters: params);
    return Files.fromJson(response.data);
  }

  /// 删除文件
  static Future deleteFile(String id) async {
    var response = await http.delete('/api/assets/files/' + id);
    return response.statusCode;
  }

  /// 获取单个文件
  static Future fetchFileItem(String id) async {
    var response = await http.get('/api/assets/files/' + id);
    return FileItem.fromJson(response.data);
  }
}
