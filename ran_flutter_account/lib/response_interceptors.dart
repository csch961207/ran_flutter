import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:ran_flutter_account/account_api.dart';

/// api拦截器
class AccountResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    debugPrint('---api-response--->resp----->${response.statusCode}');
    debugPrint('---api-response--->resp----->${response.data}');
    return accountHttp.resolve(response);
  }
}