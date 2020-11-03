import 'package:ran_flutter_assets/response_interceptors.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

final Http assetsHttp = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = ConfigService.getApiUrl(key: "RanAssets");
    interceptors..add(ApiInterceptor())..add(AssetsResponseInterceptors());
  }
}
