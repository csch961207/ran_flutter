class Environment {
  static Map<String, dynamic> apis;
  static Map<String, dynamic> oAuthConfig;
  static void setApis(Map<String, dynamic> json) {
    apis = json;
  }

  static void setOAuthConfig(Map<String, dynamic> json) {
    oAuthConfig = json;
  }
}

class ConfigService {
  static String getApiUrl({String key = "default"}) {
    if (Environment.apis[key] == null) {
      return Environment.apis["default"];
    }
    return Environment.apis[key];
  }
}
