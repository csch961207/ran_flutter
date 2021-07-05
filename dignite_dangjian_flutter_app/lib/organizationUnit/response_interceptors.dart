import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

/// api拦截器
class OrganizationUnitResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('---api-response--->resp----->${response.statusCode}');
    debugPrint('---api-response--->resp----->${response.data}');
    return super.onResponse(response, handler);
  }
}