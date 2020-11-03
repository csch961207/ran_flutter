import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_fields/model/field_model.dart';
import 'package:ran_flutter_fields/model/field_type_provider_model.dart';
import 'package:ran_flutter_fields/widget/field_types.dart';

class FieldTypeProvider {
  static List<FieldTypeProviderModel> fields = [];

  static void init() {
    addFieldTypeProviderModel(FieldTypes.allFieldTypes);
  }

  static void addFieldTypeProviderModel(
      List<FieldTypeProviderModel> fieldTypeProviders) {
    fields.insertAll(0, fieldTypeProviders);
  }

  static Widget getFieldTypeProviderWidget(Field field) {
    FieldTypeProviderModel findField = fields.firstWhere(
        (item) => item.fieldTypeName == field.fieldTypeName,
        orElse: () => new FieldTypeProviderModel());
    if (findField.fieldTypeWidget == null) {
      return Center(
        child: Text(
          '未找到相关组件',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
    return findField.fieldTypeWidget(field);
  }
}
