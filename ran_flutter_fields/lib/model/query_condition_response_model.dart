class QueryConditionResponse {
  String queryConditionsMd5;
  List<QueryEntityByFields> queryEntityByFields;

  QueryConditionResponse({this.queryConditionsMd5, this.queryEntityByFields});

  QueryConditionResponse.fromJson(Map<String, dynamic> json) {
    queryConditionsMd5 = json['queryConditionsMd5'];
    if (json['queryEntityByFields'] != null) {
      queryEntityByFields = new List<QueryEntityByFields>();
      json['queryEntityByFields'].forEach((v) {
        queryEntityByFields.add(new QueryEntityByFields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queryConditionsMd5'] = this.queryConditionsMd5;
    if (this.queryEntityByFields != null) {
      data['queryEntityByFields'] =
          this.queryEntityByFields.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QueryEntityByFields {
  String fieldId;
  int valueType;
  Null values;
  int matchingMode;

  QueryEntityByFields(
      {this.fieldId, this.valueType, this.values, this.matchingMode});

  QueryEntityByFields.fromJson(Map<String, dynamic> json) {
    fieldId = json['fieldId'];
    valueType = json['valueType'];
    values = json['values'];
    matchingMode = json['matchingMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldId'] = this.fieldId;
    data['valueType'] = this.valueType;
    data['values'] = this.values;
    data['matchingMode'] = this.matchingMode;
    return data;
  }
}