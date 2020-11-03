class CkEditor {
  int modeType;
  bool required;
  Null description;
  String assemblyNameAndTypeName;

  CkEditor(
      {this.modeType,
        this.required,
        this.description,
        this.assemblyNameAndTypeName});

  CkEditor.fromJson(Map<String, dynamic> json) {
    modeType = json['modeType'];
    required = json['required'];
    description = json['description'];
    assemblyNameAndTypeName = json['assemblyNameAndTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modeType'] = this.modeType;
    data['required'] = this.required;
    data['description'] = this.description;
    data['assemblyNameAndTypeName'] = this.assemblyNameAndTypeName;
    return data;
  }
}