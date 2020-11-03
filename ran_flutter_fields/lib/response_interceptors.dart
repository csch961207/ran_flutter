import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:ran_flutter_fields/fields_api.dart';


/// api拦截器
class FieldsResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    debugPrint('---api-response--->resp----->${response.statusCode}');
    debugPrint('---api-response--->resp----->${response.data}');
    return fieldsHttp.resolve(response);
  }
}