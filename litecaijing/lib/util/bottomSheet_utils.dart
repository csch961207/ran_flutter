import 'package:flutter/material.dart';
import 'package:litecaijing/util/theme_utils.dart';

class BottomSheetUtils {
  static showBottomSheet(BuildContext context, Widget widget, {int height}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,

      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: height != null ? height : 200,
          padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: ThemeUtils.isDark(context)
                ? ThemeUtils.getStickyHeaderColor(context)
                : Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget,
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(13),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: ThemeUtils.isDark(context)
                        ? ThemeUtils
                        .getBackgroundColor(
                        context)
                        : Color.fromRGBO(240, 240, 240, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '取消',
                        style: TextStyle(
                            fontSize: 17, color: ThemeUtils.isDark(context)
                            ? Colors.white
                            : Color.fromRGBO(93, 92, 92, 1)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}