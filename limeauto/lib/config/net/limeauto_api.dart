import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:limeauto/config/router_manger.dart';
import 'api.dart';
import '../storage_manager.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
//    options.baseUrl = 'http://host.limeauto.com.cn/';
    options.baseUrl = 'http://blogapi.abpone.com';
    interceptors..add(ApiInterceptor())
//      ..add(AuthInterceptor())
        ;
  }
}

final AccountHttp accountHttp = AccountHttp();

class AccountHttp extends BaseHttp {
  @override
  void init() {
//    options.baseUrl = 'http://host.limeauto.com.cn/';
    options.baseUrl = 'https://account.abpone.com';
    interceptors..add(ApiInterceptor())
//      ..add(AuthInterceptor())
        ;
  }
}

//class AuthInterceptor extends Interceptor{
//  @override
//  onRequest(RequestOptions options) {
//    String accessToken = StorageManager.localStorage.getItem("accessToken");
//    if (accessToken.isNotEmpty){
//      options.headers["Authorization"] = "Bearer $accessToken";
//    }
//    return super.onRequest(options);
//  }
//}

/// api拦截器
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
    debugPrint('---api-request--->data--->${options.data}');
    String accessToken = StorageManager.sharedPreferences.getString("accessToken");
    if (accessToken != null) {
      options.headers["Authorization"] = "Bearer $accessToken";
    }
    options.headers["__tenant"] = "limeauto";
    return options;
  }

  @override
  onResponse(Response response) {
    debugPrint('---api-response--->resp----->${response.data}');
    Map<String, dynamic> res = Map();
    res["errorCode"] = response.statusCode;
    res["data"] = response.data;
    ResponseData respData = ResponseData.fromJson(res);
    debugPrint('---respData----->${respData.data}');
    if (respData.success) {
      response.data = respData.data;
      return http.resolve(response);
    } else {
      if (respData.code == 401) {
        LimeAutoRouter.navigatorKey.currentState.pushNamed("login");
        throw const UnAuthorizedException(); // 需要登录
      } else {
        throw NotSuccessException.fromRespData(respData);
      }
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => 200 == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}
