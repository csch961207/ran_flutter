import 'package:flutter/material.dart';
import 'package:ran_flutter_fields/ran_flutter_fields.dart';
import 'package:ran_flutter_site/model/entities_model.dart';
import 'package:ran_flutter_site/model/section_model.dart';

typedef FileItemWidgetBuilder<T> = Widget Function(
    BuildContext context, FieldValue fieldValue);

class FindFieldValueWidget extends StatelessWidget {
  Section section;
  String fieldName;
  List<FieldValue> fieldValues;
  FileItemWidgetBuilder<FieldValue> builder;
  FindFieldValueWidget(this.section, this.fieldName, this.fieldValues,
      {Key key, @required this.builder});

  @override
  Widget build(BuildContext context) {
    Field findField;
    section.entityTypes.forEach((entityType) {
      entityType.fieldTabs.forEach((fieldTab) {
        fieldTab.fields.forEach((field) {
          if (field.name == fieldName) {
            findField = field;
          }
        });
      });
    });
    FieldValue findFieldValue;
    fieldValues.forEach((fieldValue) {
      if (fieldValue.fieldId == findField.id) {
        findFieldValue = fieldValue;
      }
    });
    if (findFieldValue != null) {
      print('走了');
      return builder(context, findFieldValue);
    } else {
      return Container();
    }
  }
}
