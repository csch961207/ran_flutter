import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class VersionUtils {
  static const MethodChannel _channel = const MethodChannel('version');
  static PackageInfo packageInfo;

  /// 应用安装
  static void install(String path) {
    try {
      _channel.invokeMethod("installApk", {'path': path});
    } catch (e) {
      print('错误');
      print(e);
    }
  }

  /// AppStore跳转
  static void jumpAppStore() {
    _channel.invokeMethod("jumpAppStore");
  }

  ///获取包信息初始化
  static init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  ///获取APP版本号
  static dynamic getVersionString() {
    try {
      return packageInfo.version.toString();
    } catch (e) {
      print(e);
      return '';
    }
  }
}