
class Assets {
  List<String> assetsSources;
  int minimum;
  int maximum;
  bool required;
  String description;
  String assemblyNameAndTypeName;

  Assets(
      {this.assetsSources,
        this.minimum,
        this.maximum,
        this.required,
        this.description,
        this.assemblyNameAndTypeName});

  Assets.fromJson(Map<String, dynamic> json) {
    assetsSources = json['assetsSources'].cast<String>();
    minimum = json['minimum'];
    maximum = json['maximum'];
    required = json['required'];
    description = json['description'];
    assemblyNameAndTypeName = json['assemblyNameAndTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assetsSources'] = this.assetsSources;
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    data['required'] = this.required;
    data['description'] = this.description;
    data['assemblyNameAndTypeName'] = this.assemblyNameAndTypeName;
    return data;
  }
}