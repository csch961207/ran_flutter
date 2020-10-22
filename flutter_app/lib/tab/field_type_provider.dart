import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/tab/field.dart';
import 'package:flutter_app/tab/field_type_provider_model.dart';

class FieldTypeProvider {
  static List<FieldTypeProviderModel> fields = [];


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
        child: Text('未找到相关组件', style: TextStyle(color: Colors.red),),
      );
    }
    return findField.fieldTypeWidget(field);
  }
}