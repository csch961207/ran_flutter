import 'package:ran_flutter_account/response_interceptors.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

final Http accountHttp = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = ConfigService.getApiUrl(key: "RanAccount");
    interceptors..add(ApiInterceptor())..add(AccountResponseInterceptors());
  }
}
