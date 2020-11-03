import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_fields/response_interceptors.dart';

final Http fieldsHttp = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = ConfigService.getApiUrl(key: "RanFields");
    interceptors..add(ApiInterceptor())..add(FieldsResponseInterceptors());
  }
}
