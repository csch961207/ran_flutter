import '../../service/http_api.dart';

import 'api.dart';
import 'request_interceptor.dart';
import 'response_interceptors.dart';
import 'dio_log_interceptor.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = HttpApi.basicsApi;
    interceptors
      ..add(DioLogInterceptor())
      ..add(RequestInterceptor())
      ..add(ResponseInterceptors());
  }
}
