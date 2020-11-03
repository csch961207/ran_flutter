import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:ran_flutter_message/message_api.dart';

/// api拦截器
class MessageResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    debugPrint('---api-response--->resp----->${response.statusCode}');
    debugPrint('---api-response--->resp----->${response.data}');
    return messageHttp.resolve(response);
  }
}