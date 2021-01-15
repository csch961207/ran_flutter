import 'package:dio/dio.dart';
import 'http.dart';

/// api拦截器
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    return http.resolve(response);
  }
}
