import 'package:flutter/material.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class ClickItem extends StatelessWidget {
  const ClickItem(
      {Key key,
      this.onLongPress,
      this.onTap,
      this.icon,
      this.widgetIcon,
      @required this.title,
      this.titleTextStyle,
      this.content: "",
      this.widgetContent,
      this.textAlign: TextAlign.start,
      this.maxLines: 1,
      this.isRequired: false})
      : super(key: key);

  final GestureTapCallback onLongPress;
  final GestureTapCallback onTap;
  final String icon;
  final Widget widgetIcon;
  final String title;
  final TextStyle titleTextStyle;
  final String content;
  final Widget widgetContent;
  final TextAlign textAlign;
  final int maxLines;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        padding: const EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
        constraints:
            BoxConstraints(maxHeight: double.infinity, minHeight: 50.0),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        )),
        child: Row(
          //为了数字类文字居中
          crossAxisAlignment: maxLines == 1
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: <Widget>[
            icon != null
                ? Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Image.asset(
                      ImageHelper.wrapAssets(icon),
                      width: 20,
                      height: 20,
                      fit: BoxFit.fitWidth,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  )
                : SizedBox(),
            widgetIcon != null
                ? Padding(
              padding: EdgeInsets.only(right: 5),
              child: widgetIcon,
            )
                : SizedBox(),
            Text(
              title,
              style: titleTextStyle != null ? titleTextStyle : TextStyle(),
            ),
            isRequired?Text(" *",style: TextStyle(color: Colors.red),):Gaps.empty,
            const Spacer(),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                child: widgetContent != null
                    ? Container(
                  alignment: Alignment.centerRight,
                  child: widgetContent,
                )
                    : Text(content,
                        maxLines: maxLines,
                        textAlign: maxLines == 1 ? TextAlign.right : textAlign,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(fontSize: 14.0)),
              ),
            ),
            onTap == null ? SizedBox() : Padding(
              padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
