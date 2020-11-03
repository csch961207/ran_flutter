import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_fields/model/field_model.dart';
import 'package:ran_flutter_fields/widget/light_switch/light_switch.dart';

class LightSwitchWidget extends StatefulWidget {
  final Field field;
  LightSwitchWidget({Key key, this.field}) : super(key: key);

  @override
  LightSwitchWidgetState createState() => LightSwitchWidgetState();
}

class LightSwitchWidgetState extends State<LightSwitchWidget> {
  LightSwitch lightSwitch = new LightSwitch();

  @override
  void initState() {
    super.initState();
    lightSwitch = LightSwitch.fromJson(widget.field.configuration);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        lightSwitch.defaultValue ? '选中的' : '未选中的',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}

Widget getNewLightSwitchBuild(Field field) {
  return LightSwitchWidget(
    field: field,
  );
}
