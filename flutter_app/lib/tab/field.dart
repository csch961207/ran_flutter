class Field {
  String fieldTypeName;
  Map<String, Object> configuration;
  Field({this.fieldTypeName, this.configuration});

  Field.fromJson(Map<String, dynamic> json) {
    fieldTypeName = json['fieldTypeName'];
    configuration = json['configuration'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldTypeName'] = this.fieldTypeName;
    data['configuration'] = this.configuration;
    return data;
  }
}