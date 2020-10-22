class LightSwitch {
  bool defaultValue;
  bool required;
  Null description;
  String assemblyNameAndTypeName;

  LightSwitch(
      {this.defaultValue,
        this.required,
        this.description,
        this.assemblyNameAndTypeName});

  LightSwitch.fromJson(Map<String, dynamic> json) {
    defaultValue = json['defaultValue'];
    required = json['required'];
    description = json['description'];
    assemblyNameAndTypeName = json['assemblyNameAndTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defaultValue'] = this.defaultValue;
    data['required'] = this.required;
    data['description'] = this.description;
    data['assemblyNameAndTypeName'] = this.assemblyNameAndTypeName;
    return data;
  }
}