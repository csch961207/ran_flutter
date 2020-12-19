import 'package:flutter/material.dart';
import 'package:ran_flutter_fields/ran_flutter_fields.dart';
import 'package:ran_flutter_site/model/entities_model.dart';
import 'package:ran_flutter_site/model/parse_field_provider_model.dart';
import 'package:ran_flutter_site/parse_fields.dart';

class ParseFieldProvider {
  static List<ParseFieldProviderModel> parseFields = [];

  static void init() {
    addParseFieldProviderModel(ParseFields.allParseFields);
  }

  static void addParseFieldProviderModel(
      List<ParseFieldProviderModel> parseFieldProviders) {
    parseFields.insertAll(0, parseFieldProviders);
  }

  static getParseFieldValue(Field field, FieldValue fieldValue) {
    ParseFieldProviderModel findParseField = parseFields.firstWhere(
        (item) => item.fieldTypeName == field.fieldTypeName,
        orElse: () => new ParseFieldProviderModel());
    if (findParseField.parseFieldValue == null) {
      return Center(
        child: Text(
          '未找到相关解析方法',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
    return findParseField.parseFieldValue(field, fieldValue);
  }
}
