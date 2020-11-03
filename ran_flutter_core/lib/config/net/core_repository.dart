import 'package:dio/dio.dart';
import 'package:ran_flutter_core/config/net/http.dart';
import 'package:ran_flutter_core/model/application_configuration_model.dart';

class CoreRepository {
  /// 获取应用程序配置
  static Future<ApplicationConfiguration> fetchApplicationConfiguration() async {
    var response = await http.get('/api/abp/application-configuration');
    return ApplicationConfiguration.fromJson(response.data);
  }
}
