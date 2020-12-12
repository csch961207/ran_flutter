class RadioButtonList {
  List<ListItems> listItems;
  bool required;
  Null description;
  String assemblyNameAndTypeName;

  RadioButtonList(
      {this.listItems,
        this.required,
        this.description,
        this.assemblyNameAndTypeName});

  RadioButtonList.fromJson(Map<String, dynamic> json) {
    if (json['listItems'] != null) {
      listItems = new List<ListItems>();
      json['listItems'].forEach((v) {
        listItems.add(new ListItems.fromJson(v));
      });
    }
    required = json['required'];
    description = json['description'];
    assemblyNameAndTypeName = json['assemblyNameAndTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listItems != null) {
      data['listItems'] = this.listItems.map((v) => v.toJson()).toList();
    }
    data['required'] = this.required;
    data['description'] = this.description;
    data['assemblyNameAndTypeName'] = this.assemblyNameAndTypeName;
    return data;
  }
}

class ListItems {
  bool selected;
  String label;
  String id;

  ListItems({this.selected, this.label, this.id});

  ListItems.fromJson(Map<String, dynamic> json) {
    selected = json['selected'];
    label = json['label'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selected'] = this.selected;
    data['label'] = this.label;
    data['id'] = this.id;
    return data;
  }
}