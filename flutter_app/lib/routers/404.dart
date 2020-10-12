import 'package:flutter/material.dart';
import 'package:junchengedmsflutterapp/widget/my_app_bar.dart';
import 'package:junchengedmsflutterapp/widget/state_layout.dart';


class WidgetNotFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        centerTitle: "页面不存在",
      ),
      body: StateLayout(
        type: StateType.account,
        hintText: "页面不存在",
      ),
    );
  }
}
