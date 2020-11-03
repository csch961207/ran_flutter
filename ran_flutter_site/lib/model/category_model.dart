import 'package:ran_flutter_site/model/entities_model.dart';
import 'package:ran_flutter_site/model/section_model.dart';

class Categories {
  List<Category> items;

  Categories({this.items});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Category>();
      json['items'].forEach((v) {
        items.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String groupId;
  bool isActive;
  String parentId;
  String code;
  String displayName;
  Group group;
  List<FieldValues> fieldValues;
  String id;

  Category(
      {this.groupId,
      this.isActive,
      this.parentId,
      this.code,
      this.displayName,
      this.group,
      this.fieldValues,
      this.id});

  Category.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    isActive = json['isActive'];
    parentId = json['parentId'];
    code = json['code'];
    displayName = json['displayName'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    if (json['fieldValues'] != null) {
      fieldValues = new List<FieldValues>();
      json['fieldValues'].forEach((v) {
        fieldValues.add(new FieldValues.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    data['isActive'] = this.isActive;
    data['parentId'] = this.parentId;
    data['code'] = this.code;
    data['displayName'] = this.displayName;
    if (this.group != null) {
      data['group'] = this.group.toJson();
    }
    if (this.fieldValues != null) {
      data['fieldValues'] = this.fieldValues.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Group {
  String displayName;
  String name;
  List<FieldTabs> fieldTabs;
  String id;

  Group({this.displayName, this.name, this.fieldTabs, this.id});

  Group.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    name = json['name'];
    if (json['fieldTabs'] != null) {
      fieldTabs = new List<FieldTabs>();
      json['fieldTabs'].forEach((v) {
        fieldTabs.add(new FieldTabs.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['name'] = this.name;
    if (this.fieldTabs != null) {
      data['fieldTabs'] = this.fieldTabs.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}
