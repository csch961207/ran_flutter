class Field {
  String label;
  String name;
  String description;
  String fieldTypeName;
  bool addedToEntityList;
  bool addedToSearchOptions;
  bool supportMultipleSearchOption;
  Map<String, Object> configuration;
  String id;

  Field(
      {this.label,
        this.name,
        this.description,
        this.fieldTypeName,
        this.addedToEntityList,
        this.addedToSearchOptions,
        this.supportMultipleSearchOption,
        this.configuration,
        this.id});

  Field.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    name = json['name'];
    description = json['description'];
    fieldTypeName = json['fieldTypeName'];
    addedToEntityList = json['addedToEntityList'];
    addedToSearchOptions = json['addedToSearchOptions'];
    supportMultipleSearchOption = json['supportMultipleSearchOption'];
    configuration = json['configuration'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['name'] = this.name;
    data['description'] = this.description;
    data['fieldTypeName'] = this.fieldTypeName;
    data['addedToEntityList'] = this.addedToEntityList;
    data['addedToSearchOptions'] = this.addedToSearchOptions;
    data['supportMultipleSearchOption'] = this.supportMultipleSearchOption;
    data['configuration'] = this.configuration;
    data['id'] = this.id;
    return data;
  }
}