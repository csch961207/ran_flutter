//import 'package:dio/dio.dart';
//import 'package:limeauto/config/storage_manager.dart';
//
//class AuthInterceptor extends Interceptor {
//  @override
//  onRequest(RequestOptions options) {
//    String accessToken = StorageManager.localStorage.getItem("accessToken");
//    if (accessToken.isNotEmpty) {
//      options.headers["Authorization"] = "Bearer $accessToken";
//      options.headers["__tenant"] = "litecaijing";
//    }
//    return super.onRequest(options);
//  }
//}
