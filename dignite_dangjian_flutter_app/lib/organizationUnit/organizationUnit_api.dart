import 'package:ran_flutter_core/ran_flutter_core.dart';

import 'response_interceptors.dart';

final Http organizationUnitHttp = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = ConfigService.getApiUrl(key: "RanAccount");
    interceptors..add(ApiInterceptor())..add(OrganizationUnitResponseInterceptors());
  }
}
