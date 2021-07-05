import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';


/// 封装输入框
class TextFieldItem extends StatelessWidget {

  const TextFieldItem({
    Key key,
    this.controller,
    this.title,
    this.keyboardType: TextInputType.text,
    this.hintText: "",
    this.focusNode,
    this.config,
    this.obscureText: false,
    this.isRequired: false
  }): super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final KeyboardActionsConfig config;
  final bool obscureText;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    if (config != null && defaultTargetPlatform == TargetPlatform.iOS){
      // 因Android平台输入法兼容问题，所以只配置IOS平台
//      KeyboardActions.setKeyboardActions(context, config);
    }
    return Container(
      height: 50.0,
      margin:  const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.6),
          )
      ),
      child: Row(
        children: <Widget>[
          title != null ? Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Text(title),
                isRequired?Text(" *",style: TextStyle(color: Colors.red),):Gaps.empty
              ],
            ),
          ) : Gaps.empty,
          Expanded(
            flex: 1,
            child: TextField(
                obscureText: obscureText,
                focusNode: focusNode,
                keyboardType: keyboardType,
                inputFormatters: _getInputFormatters(),
                controller: controller,
                //style: TextStyles.textDark14,
                decoration: InputDecoration(
                  hintText: hintText,
//                  helperStyle: TextStyle((fontSize: 14),
                  border: InputBorder.none, //去掉下划线
                  //hintStyle: TextStyles.textGrayC14
                ),
            ),
          ),
          Gaps.hGap16
        ],
      ),
    );
  }

  _getInputFormatters(){
//    if (keyboardType == TextInputType.numberWithOptions(decimal: true)){
//      return [UsNumberTextInputFormatter()];
//    }
//    if (keyboardType == TextInputType.number || keyboardType == TextInputType.phone){
//      return [WhitelistingTextInputFormatter.digitsOnly];
//    }
    if (keyboardType == TextInputType.phone){
      return [LengthLimitingTextInputFormatter(20)];
    }
    return null;
  }
}