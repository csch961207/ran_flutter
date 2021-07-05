import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:ran_flutter_core/config/net/http.dart';


/// api拦截器
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('---api-response--->resp----->${response.statusCode}');
    debugPrint('---api-response--->resp----->${response.data}');
    return super.onResponse(response, handler);
  }
}