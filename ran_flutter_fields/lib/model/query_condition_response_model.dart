class QueryConditionResponse {
  String name;
  List<QueryByFields> queryByFields;

  QueryConditionResponse({this.name, this.queryByFields});

  QueryConditionResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['queryByFields'] != null) {
      queryByFields = new List<QueryByFields>();
      json['queryByFields'].forEach((v) {
        queryByFields.add(new QueryByFields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.queryByFields != null) {
      data['queryByFields'] =
          this.queryByFields.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QueryByFields {
  String fieldId;
  int valueType;

  QueryByFields(
      {this.fieldId, this.valueType});

  QueryByFields.fromJson(Map<String, dynamic> json) {
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