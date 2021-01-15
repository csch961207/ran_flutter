import 'package:dayansoft/utils/theme_utils.dart';
import 'package:flutter/material.dart';

import '../config/routers/fluro_navigator.dart';
import '../res/resources.dart';

/// 自定义dialog的模板
class BaseDialog extends StatelessWidget {
  const BaseDialog(
      {Key key,
        this.title,
        this.confirmText,
        this.cancelText,
        this.onPressed,
        this.hiddenTitle: false,
        this.showCancel: true,
        @required this.child})
      : super(key: key);

  final String title;
  final String confirmText;
  final String cancelText;
  final Function onPressed;
  final Widget child;
  final bool hiddenTitle;
  final bool showCancel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //创建透明层
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      // 键盘弹出收起动画过渡
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: Container(
            decoration: BoxDecoration(
              color: ThemeUtils.getDialogBackgroundColor(context),
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 270.0,
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Offstage(
                  offstage: hiddenTitle,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      hiddenTitle ? "" : title ?? "提示",
                      style: TextStyles.textBold18,
                    ),
                  ),
                ),
                Flexible(child: child),
                Gaps.vGap10,
                Gaps.line,
                Row(
                  children: <Widget>[
                    showCancel
                        ? Expanded(
                      child: SizedBox(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            cancelText ?? "取消",
                            style: TextStyle(fontSize: Dimens.font_sp18),
                          ),
                          textColor: Colors.black,
                          onPressed: () {
                            NavigatorUtils.goBack(context);
                          },
                        ),
                      ),
                    )
                        : Container(),
                    showCancel
                        ? const SizedBox(
                      height: 48.0,
                      width: 0.6,
                      child: const VerticalDivider(),
                    )
                        : Container(),
                    Expanded(
                      child: SizedBox(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            confirmText ?? "确定",
                            style: TextStyle(fontSize: Dimens.font_sp18),
                          ),
                          textColor: Theme.of(context).accentColor,
                          onPressed: () {
                            onPressed();
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
