import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

export 'package:dio/dio.dart';

// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    /// 初始化 加入app通用处理
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

    /// 忽略https证书效验
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
      client.badCertificateCallback=(X509Certificate cert, String host, int port){
//        if(cert.pem==PEM){ // Verify the certificate
//          return true;
//        }
        return true;
      };
    };
    interceptors..add(HeaderInterceptor());
    init();
  }

  void init();
}

/// 添加常用Header
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.connectTimeout = 1000 * 45;
    options.receiveTimeout = 1000 * 45;
    return super.onRequest(options,handler);
  }
}

/// 子类需要重写
abstract class BaseResponseData {
  int code = 0;
  String message;
  dynamic data;

  bool get success;

  BaseResponseData({this.code, this.message, this.data});

  @override
  String toString() {
    return 'BaseRespData{code: $code, message: $message, data: $data}';
  }
}

/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String message;

  NotSuccessException.fromRespData(BaseResponseData respData) {
    message = respData.message;
  }

  @override
  String toString() {
    return 'NotExpectedException{respData: $message}';
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}
