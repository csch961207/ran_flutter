import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ran_flutter_core/config/routers/fluro_navigator.dart';
import 'package:ran_flutter_core/config/storage_manager.dart';
import 'package:ran_flutter_core/utils/toast_util.dart';
import 'package:ran_flutter_core/utils/utils.dart';
import 'package:ran_flutter_core/widget/base_dialog.dart';
import 'package:ran_flutter_core/widget/load_image.dart';

/// [e]分类Error和Exception两种
void getErrorTips(e, stackTrace, {String message, BuildContext context}) {
  /// 见https://github.com/flutterchina/dio/blob/master/README-ZH.md#dioerrortype
  if (e is DioError) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT ||
        e.type == DioErrorType.SEND_TIMEOUT ||
        e.type == DioErrorType.RECEIVE_TIMEOUT) {
      // timeout
      ToastUtil.show("请求超时");
      print(e.toString());
    } else if (e.type == DioErrorType.RESPONSE) {
      // incorrect status, such as 404, 503...
      print(e.toString());
      print("错误");
      print(e.response.data);

      if (e.response.statusCode == 401) {
        StorageManager.sharedPreferences.setString("accessToken", '');
        StorageManager.sharedPreferences.setString("userName", '');
//        NavigatorUtils.push(context, LoginRouter.loginPage,
//                      replace: true, clearStack: true);
        showElasticDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return BaseDialog(
//                showCancel: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child:
                      const Text("登录信息已失效，请重新登录", textAlign: TextAlign.center),
                ),
                onPressed: () {
                  NavigatorUtils.goBack(context);
                  NavigatorUtils.push(context, '/account/login');
                },
              );
            });
      }

      if (e.response.statusCode == 500) {
        showElasticDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return BaseDialog(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text("对不起,在处理你的请求期间,产生了一个服务器内部错误!",
                      textAlign: TextAlign.center),
                ),
                onPressed: () {
                  NavigatorUtils.goBack(context);
                },
              );
            });
      }

      if (e.response.statusCode == 403) {
        showElasticDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return BaseDialog(
                title: e.response.data['error']['details'] != null
                    ? e.response.data['error']['message']
                    : "提示",
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                      e.response.data['error']['details'] != null
                          ? e.response.data['error']['details']
                          : e.response.data['error']['message'] ?? '',
                      textAlign: TextAlign.center),
                ),
                onPressed: () {
                  NavigatorUtils.goBack(context);
                },
              );
            });
      }

      if (e.response.statusCode == 404) {
        showElasticDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return BaseDialog(
                title: "未找到资源!",
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child:
                      const Text("未在服务中找到请求的资源!", textAlign: TextAlign.center),
                ),
                onPressed: () {
                  NavigatorUtils.goBack(context);
                },
              );
            });
      }

      if (e.response.statusCode == 400) {
        print("400错误");
        if (e.response.data['error'] == "invalid_grant" ||
            e.response.data['error'] == "invalid_client") {
          ToastUtil.show("用户名或密码无效");
        } else {
          showElasticDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return BaseDialog(
                  title: e.response.data['error']['details'] != null
                      ? e.response.data['error']['message']
                      : "提示",
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                        e.response.data['error']['details'] != null
                            ? e.response.data['error']['details']
                            : e.response.data['error']['message'] ?? '',
                        textAlign: TextAlign.center),
                  ),
                  onPressed: () {
                    NavigatorUtils.goBack(context);
                  },
                );
              });
        }
      }
    } else if (e.type == DioErrorType.CANCEL) {
      // to be continue...
      ToastUtil.show("请求被取消");
      print(e.toString());
    } else {
      // dio将原error重新套了一层
      print(e.toString());
      print('错误');
    }
  }
}
