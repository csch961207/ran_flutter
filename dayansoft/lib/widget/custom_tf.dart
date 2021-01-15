import '../res/resources.dart';
import 'package:flutter/material.dart';

class CustomTF extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final IconData icon;
  final focusNode;

  final TextInputType keyboardType;

  CustomTF({
    Key key,
    @required this.title,
    this.controller,
    this.hintText,
    this.obscure: false,
    this.icon,
    this.focusNode,
    this.keyboardType: TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('$title', style: TextStyles.kLabelStyle),
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextField(
                  keyboardType: keyboardType,
                  controller: controller,
                  focusNode: focusNode,
                  obscureText: obscure,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(icon, color: Colors.white),
                      hintText: '$hintText',
                      hintStyle: TextStyles.kHintTextStyle)))
        ]);
  }
}
