import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:ran_flutter_core/config/net/http.dart';
import 'package:ran_flutter_core/config/storage_manager.dart';

/// api拦截器
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
    debugPrint('---api-request--->data--->${options.data}');
    String accessToken =
        StorageManager.sharedPreferences.getString("accessToken");
    String tenant = StorageManager.sharedPreferences.getString("tenant");
    if (accessToken != null && accessToken != '') {
      options.headers["Authorization"] = "Bearer $accessToken";
    }
    print(options.headers["Authorization"]);
    if (tenant != null && tenant != '') {
      options.headers["__tenant"] = tenant;
    }
    return super.onRequest(options,handler);
  }
}
