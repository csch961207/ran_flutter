import 'dart:convert';

import 'package:dayansoft/config/net/api.dart';
import 'package:dayansoft/model/allEvents.dart';
import 'package:dayansoft/model/countFiles.dart';
import 'package:dayansoft/model/nowTime.dart';
import 'package:dayansoft/model/user.dart';

import '../config/net/http.dart';
import 'http_api.dart';

class AppRepository {
  /// 登录
  static Future<User> login(String loginName, String password) async {
    Map<String, String> params = Map();
    params["loginName"] = loginName;
    params["password"] = password;
    var response = await http.post(HttpApi.login, queryParameters: params);
    return User.fromJson(json.decode(response.data));
  }

  /// 活动列表
  static Future findAllEvents(int userId, int dealershipId, int pageCurrent,
      int pageSize, String date) async {
    Map<String, String> params = Map();
    params["userId"] = userId.toString();
    params["dealershipId"] = dealershipId.toString();
    params["pageCurrent"] = pageCurrent.toString();
    params["pageSize"] = pageSize.toString();
    params["date"] = date;
    var response =
        await http.get(HttpApi.findAllEvents, queryParameters: params);
    return AllEvents.fromJson(json.decode(response.data));
  }

  /// 活动服务器时间
  static Future<NowTime> getNowTime() async {
    var response = await http.get(HttpApi.getNowTime);
    return NowTime.fromJson(json.decode(response.data));
  }

  /// 获取指定活动附件数量接口（用于限制最大上传数量100个）
  static Future<CountFiles> fetchFileItem(String eventId) async {
    var response = await http.get(HttpApi.countFilesByEventId,
        queryParameters: {"eventId": eventId});
    return CountFiles.fromJson(json.decode(response.data));
  }

  /// 上传文件
  static Future upload(String filePath, int eventid, int userId,
      int photoshootpositionLng, int photoshootpositionLat) async {
    var name = filePath.substring(filePath.lastIndexOf("/") + 1);
    var fromFile = await MultipartFile.fromFile(filePath, filename: name);
    FormData formData = FormData.fromMap({
      "files": fromFile,
      "eventid": eventid,
      "userId": userId,
      "photoshootpositionLng": photoshootpositionLng,
      "photoshootpositionLat": photoshootpositionLat,
      "sceneName": 'phoneShot',
      "sceneType": 1,
      "sceneId": 1,
      "Resolution": 1
    });
    var response = await http.post(HttpApi.uploader, data: formData);
    print(response);
//    return .fromJson(response.data);
  }
}
