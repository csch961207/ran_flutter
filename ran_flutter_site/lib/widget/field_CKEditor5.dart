import 'package:flutter/material.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_fields/ran_flutter_fields.dart';
import 'package:ran_flutter_fields/ran_flutter_fields.dart';
import 'package:ran_flutter_site/model/entities_model.dart';

/// CkEditor字段渲染
class FieldCkEditor extends StatefulWidget {
  final Field field;
  final FieldValue fieldValue;
  FieldCkEditor({Key key, @required this.field, @required this.fieldValue})
      : super(key: key);

  @override
  FieldCkEditorState createState() => FieldCkEditorState();
}

class FieldCkEditorState extends State<FieldCkEditor> {
  CkEditor ckEditor = new CkEditor();

  @override
  void initState() {
    super.initState();
    this.ckEditor = CkEditor.fromJson(widget.field.configuration);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        widget.fieldValue.maxTextValue,
      ),
    );
  }
}
