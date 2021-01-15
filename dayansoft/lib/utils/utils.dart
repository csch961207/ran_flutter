library utils;

import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'toast_util.dart';

class Utils {
  static final DateFormat _monthFormat = new DateFormat("MMMM yyyy");
  static final DateFormat _dayFormat = new DateFormat("dd");
  static final DateFormat _firstDayFormat = new DateFormat("MMM dd");
  static final DateFormat _fullDayFormat = new DateFormat("EEE MMM dd, yyyy");
  static final DateFormat _apiDayFormat =
      new DateFormat("yyyy年MM月dd日 HH:mm:ss");
  static final DateFormat _daysFormat = new DateFormat("yyyy-MM-dd");
  static final DateFormat _apiDaysFormat = new DateFormat("yyyy年MM月dd日");

  static String formatMonth(DateTime d) => _monthFormat.format(d);
  static String formatDay(DateTime d) => _dayFormat.format(d);
  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);
  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);
  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);
  static String daysFormat(DateTime d) => _daysFormat.format(d);
  static String apiDaysFormat(DateTime d) => _apiDaysFormat.format(d);

  /// 调起拨号页
  static void launchTelURL(String phone) async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastUtil.show('拨号失败！');
    }
  }

  /// 调起二维码扫描页
  static Future<String> scan() async {
//    try {
//      return await scanner.scan();
//    } catch (e) {
//      if (e is PlatformException) {
//        if (e.code == scanner.CameraAccessDenied) {
//          Toast.show("没有相机权限！");
//        }
//      }
//    }
//    return null;
  }

  static String renderSize(double value) {
    if (null == value) {
      return '0';
    }
    List<String> unitArr = List()..add('B')..add('KB')..add('MB')..add('GB');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

//  static KeyboardActionsConfig getKeyboardActionsConfig(
//      BuildContext context, List<FocusNode> list) {
//    return KeyboardActionsConfig(
//      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
//      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
//      nextFocus: true,
//      actions: List.generate(
//          list.length,
//          (i) => KeyboardAction(
//                focusNode: list[i],
//                closeWidget: const Padding(
//                  padding: const EdgeInsets.all(5.0),
//                  child: const Text("关闭"),
//                ),
//              )),
//    );
//  }
}

/// 默认dialog背景色为半透明黑色，这里修改源码改为透明
Future<T> showTransparentDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: const Color(0x00FFFFFF),
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

Future<T> showElasticDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 550),
    transitionBuilder: _buildDialogTransitions,
  );
}

Widget _buildDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: animation.status != AnimationStatus.forward
            ? Curves.easeOutBack
            : ElasticOutCurve(0.85),
      )),
      child: child,
    ),
  );
}
