import 'package:ran_flutter_core/common/environment.dart';
import 'package:ran_flutter_core/config/net/Interceptor.dart';
import 'package:ran_flutter_core/config/net/response_interceptors.dart';

import 'api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = ConfigService.getApiUrl(key: "default");
    interceptors..add(ApiInterceptor())..add(ResponseInterceptors());
  }
}
