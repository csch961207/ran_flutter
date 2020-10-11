import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:ran_flutter_core/config/net/http.dart';
import 'package:ran_flutter_core/config/storage_manager.dart';


/// api拦截器
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
    debugPrint('---api-request--->data--->${options.data}');
    String accessToken =
    StorageManager.sharedPreferences.getString("accessToken");
    if (accessToken != null && accessToken != '') {
      options.headers["Authorization"] = "Bearer $accessToken";
    }
    return options;
  }

  @override
  onResponse(Response response) {
    debugPrint('---api-response--->resp----->${response.statusCode}');
    debugPrint('---api-response--->resp----->${response.data}');
    return http.resolve(response);
  }
}