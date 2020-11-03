import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/response_interceptors.dart';

final Http messageHttp = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = ConfigService.getApiUrl(key: "RanMessage");
    interceptors..add(ApiInterceptor())..add(MessageResponseInterceptors());
  }
}
