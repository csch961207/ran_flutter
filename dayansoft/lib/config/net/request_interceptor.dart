import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import '../../config/storage_manager.dart';

/// api拦截器
class RequestInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    String accessToken =
        StorageManager.sharedPreferences.getString("accessToken");
    if (accessToken != null && accessToken != '') {
      options.headers["Authorization"] = "Bearer $accessToken";
    }
    return options;
  }
}
