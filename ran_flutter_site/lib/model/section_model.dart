import 'package:ran_flutter_fields/ran_flutter_fields.dart';

class Sections {
  List<Section> items;

  Sections({this.items});

  Sections.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Section>();
      json['items'].forEach((v) {
        items.add(new Section.fromJson(v));
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

class Section {
  bool isActive;
  String displayName;
  String name;
  String icon;
  String description;
  bool isPublic;
  List<EntityTypes> entityTypes;
  String type;
  String viewPage;
  String entityTypeViewPage;
  String entityViewPage;
  String id;

  Section(
      {this.isActive,
        this.displayName,
        this.name,
        this.icon,
        this.description,
        this.isPublic,
        this.entityTypes,
        this.type,
        this.viewPage,
        this.entityTypeViewPage,
        this.entityViewPage,
        this.id});

  Section.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
    displayName = json['displayName'];
    name = json['name'];
    icon = json['icon'];
    description = json['description'];
    isPublic = json['isPublic'];
    if (json['entityTypes'] != null) {
      entityTypes = new List<EntityTypes>();
      json['entityTypes'].forEach((v) {
        entityTypes.add(new EntityTypes.fromJson(v));
      });
    }
    type = json['type'];
    viewPage = json['viewPage'];
    entityTypeViewPage = json['entityTypeViewPage'];
    entityViewPage = json['entityViewPage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isActive'] = this.isActive;
    data['displayName'] = this.displayName;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['isPublic'] = this.isPublic;
    if (this.entityTypes != null) {
      data['entityTypes'] = this.entityTypes.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['viewPage'] = this.viewPage;
    data['entityTypeViewPage'] = this.entityTypeViewPage;
    data['entityViewPage'] = this.entityViewPage;
    data['id'] = this.id;
    return data;
  }
}

class EntityTypes {
  String sectionId;
  String displayName;
  String name;
  List<FieldTabs> fieldTabs;
  String viewPage;
  String id;

  EntityTypes(
      {this.sectionId,
        this.displayName,
        this.name,
        this.fieldTabs,
        this.viewPage,
        this.id});

  EntityTypes.fromJson(Map<String, dynamic> json) {
    sectionId = json['sectionId'];
    displayName = json['displayName'];
    name = json['name'];
    if (json['fieldTabs'] != null) {
      fieldTabs = new List<FieldTabs>();
      json['fieldTabs'].forEach((v) {
        fieldTabs.add(new FieldTabs.fromJson(v));
      });
    }
    viewPage = json['viewPage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sectionId'] = this.sectionId;
    data['displayName'] = this.displayName;
    data['name'] = this.name;
    if (this.fieldTabs != null) {
      data['fieldTabs'] = this.fieldTabs.map((v) => v.toJson()).toList();
    }
    data['viewPage'] = this.viewPage;
    data['id'] = this.id;
    return data;
  }
}

class FieldTabs {
  String displayName;
  List<Field> fields;

  FieldTabs({this.displayName, this.fields});

  FieldTabs.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    if (json['fields'] != null) {
      fields = new List<Field>();
      json['fields'].forEach((v) {
        fields.add(new Field.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    if (this.fields != null) {
      data['fields'] = this.fields.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
