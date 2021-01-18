import 'package:ran_flutter_fields/fields_api.dart';
import 'package:ran_flutter_fields/model/field_type_model.dart';
import 'package:ran_flutter_fields/model/query_condition_response_model.dart';
import 'package:ran_flutter_fields/model/query_entity_by_field_condition_model.dart';

class FieldsRepository {
  /// 所有字段类型
  static Future fetchFieldTypes() async {
    var response = await fieldsHttp.get('/api/fields/field/fieldTypes');
    return response.data
        .map<FieldType>((item) => FieldType.fromJson(item))
        .toList();
  }

  /// 查询单个字段
  static Future fetchField(String id) async {
    var response =
        await fieldsHttp.get('/api/fields/field', queryParameters: {"id": id});
    return FieldType.fromJson(response.data);
  }

  /// 查询多个字段
  static Future fetchFieldMany(List<String> ids) async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    var idsMap = ids.asMap();
    idsMap.forEach((key, value) {
      data[key.toString()] = value;
    });
    var response = await fieldsHttp.post('/api/fields/field/many', data: data);
    return response.data['items']
        .map<FieldType>((item) => FieldType.fromJson(item))
        .toList();
  }

  /// 生成字段查询用例
  static Future fetchQueryCondition(
      List<Map<String, dynamic>> queryEntityByFieldConditions) async {
    var response = await fieldsHttp.post('/api/fields/QueryCondition',
        data: {"queryByFields": queryEntityByFieldConditions});
    return QueryConditionResponse.fromJson(response.data);
  }

  /// 根据Md5值查找字段查询用例
  static Future fetchFindQueryCondition(String md5) async {
    var response = await fieldsHttp.post('/api/fields/QueryCondition/find/${md5}');
    return QueryConditionResponse.fromJson(response.data);
  }
}
