
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_site/response_interceptors.dart';

final Http siteHttp = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = ConfigService.getApiUrl(key: "RanAccount");
    interceptors..add(ApiInterceptor())..add(SiteResponseInterceptors());
  }
}
