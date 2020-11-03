class QueryEntityByFieldCondition {
  String fieldId;
  int valueType;

  QueryEntityByFieldCondition({this.fieldId, this.valueType});

  QueryEntityByFieldCondition.fromJson(Map<String, dynamic> json) {
    fieldId = json['fieldId'];
    valueType = json['valueType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldId'] = this.fieldId;
    data['valueType'] = this.valueType;
    return data;
  }
}
