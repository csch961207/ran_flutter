import 'package:ran_flutter_fields/ran_flutter_fields.dart';
import 'package:ran_flutter_site/model/entities_model.dart';
import 'package:ran_flutter_site/model/parse_field_provider_model.dart';

class ParseFields {
  static ParseFieldProviderModel parseAssetsFieldProvider =
      ParseFieldProviderModel(
          fieldTypeName: 'Assets', parseFieldValue: parseAssetsFieldValue);
  static String parseAssetsFieldValue(Field field, FieldValues fieldValue) {
    return '';
  }

  static ParseFieldProviderModel parseCKEditor5FieldProvider =
      ParseFieldProviderModel(
          fieldTypeName: 'CKEditor5',
          parseFieldValue: parseCKEditor5FieldValue);
  static String parseCKEditor5FieldValue(Field field, FieldValues fieldValue) {
    return fieldValue.maxTextValue;
  }

  static List<ParseFieldProviderModel> allParseFields = [
    parseAssetsFieldProvider,
    parseCKEditor5FieldProvider
  ];
}
