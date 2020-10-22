
import 'package:flutter/widgets.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_site/site_api.dart';


/// api拦截器
class SiteResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    debugPrint('---api-response--->resp----->${response.statusCode}');
    debugPrint('---api-response--->resp----->${response.data}');
    return siteHttp.resolve(response);
  }
}