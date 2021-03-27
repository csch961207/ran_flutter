import 'dart:convert';

class EntitiesListEntity {
  int totalCount;
  List<EntitiesItem> items;

  EntitiesListEntity({this.items});

  EntitiesListEntity.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = new List<EntitiesItem>();(json['items'] as List).forEach((v) { items.add(new EntitiesItem.fromJson(v)); });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.items != null) {
      data['items'] =  this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class EntitiesItem {
  String title;
  String name;
  String sectionId;
  Section section;
  String entityTypeId;
  EntityTypes entityType;
  String parentId;
  int auditStatus;
  bool isActive;
  String publishTime;
  List<FieldValues> fieldValues;
  Editor editor;
  String creationTime;
  String creatorId;
  String id;

  EntitiesItem(
      {this.title,
        this.name,
        this.sectionId,
        this.section,
        this.entityTypeId,
        this.entityType,
        this.parentId,
        this.auditStatus,
        this.isActive,
        this.publishTime,
        this.fieldValues,
        this.editor,
        this.creationTime,
        this.creatorId,
        this.id});

  EntitiesItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    sectionId = json['sectionId'];
    section =
    json['section'] != null ? new Section.fromJson(json['section']) : null;
    entityTypeId = json['entityTypeId'];
    entityType = json['entityType'] != null
        ? new EntityTypes.fromJson(json['entityType'])
        : null;
    parentId = json['parentId'];
    auditStatus = json['auditStatus'];
    isActive = json['isActive'];
    publishTime = json['publishTime'];
    if (json['fieldValues'] != null) {
      fieldValues = new List<FieldValues>();
      json['fieldValues'].forEach((v) {
        fieldValues.add(new FieldValues.fromJson(v));
      });
    }
    editor =
    json['editor'] != null ? new Editor.fromJson(json['editor']) : null;
    creationTime = json['creationTime'];
    creatorId = json['creatorId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['name'] = this.name;
    data['sectionId'] = this.sectionId;
    if (this.section != null) {
      data['section'] = this.section.toJson();
    }
    data['entityTypeId'] = this.entityTypeId;
    if (this.entityType != null) {
      data['entityType'] = this.entityType.toJson();
    }
    data['parentId'] = this.parentId;
    data['auditStatus'] = this.auditStatus;
    data['isActive'] = this.isActive;
    data['publishTime'] = this.publishTime;
    if (this.fieldValues != null) {
      data['fieldValues'] = this.fieldValues.map((v) => v.toJson()).toList();
    }
    if (this.editor != null) {
      data['editor'] = this.editor.toJson();
    }
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['id'] = this.id;
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
  String template;
  String entityTypeTemplate;
  String entityTemplate;
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
        this.template,
        this.entityTypeTemplate,
        this.entityTemplate,
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
    template = json['template'];
    entityTypeTemplate = json['entityTypeTemplate'];
    entityTemplate = json['entityTemplate'];
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
    data['template'] = this.template;
    data['entityTypeTemplate'] = this.entityTypeTemplate;
    data['entityTemplate'] = this.entityTemplate;
    data['id'] = this.id;
    return data;
  }
}

class EntityTypes {
  String sectionId;
  String displayName;
  String name;
  List<FieldTabs> fieldTabs;
  Null template;
  String id;

  EntityTypes(
      {this.sectionId,
        this.displayName,
        this.name,
        this.fieldTabs,
        this.template,
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
    template = json['template'];
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
    data['template'] = this.template;
    data['id'] = this.id;
    return data;
  }
}

class FieldTabs {
  String displayName;
  List<Fields> fields;

  FieldTabs({this.displayName, this.fields});

  FieldTabs.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    if (json['fields'] != null) {
      fields = new List<Fields>();
      json['fields'].forEach((v) {
        fields.add(new Fields.fromJson(v));
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

class Fields {
  String label;
  String name;
  Null description;
  String fieldTypeName;
  bool isIncludeInEntityList;
  String configurationData;
  String id;

  Fields(
      {this.label,
        this.name,
        this.description,
        this.fieldTypeName,
        this.isIncludeInEntityList,
        this.configurationData,
        this.id});

  Fields.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    name = json['name'];
    description = json['description'];
    fieldTypeName = json['fieldTypeName'];
    isIncludeInEntityList = json['isIncludeInEntityList'];
    configurationData = json['configurationData'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['name'] = this.name;
    data['description'] = this.description;
    data['fieldTypeName'] = this.fieldTypeName;
    data['isIncludeInEntityList'] = this.isIncludeInEntityList;
    data['configurationData'] = this.configurationData;
    data['id'] = this.id;
    return data;
  }
}

class FieldValues {
  String fieldId;
  String indexTextValue;
  dynamic numberValue;
  String dateTimeValue;
  bool booleanValue;
  String guidValue;
  String maxTextValue;

  FieldValues(
      {this.fieldId,
        this.indexTextValue,
        this.numberValue,
        this.dateTimeValue,
        this.booleanValue,
        this.guidValue,
        this.maxTextValue});

  FieldValues.fromJson(Map<String, dynamic> json) {
    fieldId = json['fieldId'];
    indexTextValue = json['indexTextValue'];
    numberValue = json['numberValue'];
    dateTimeValue = json['dateTimeValue'];
    booleanValue = json['booleanValue'];
    guidValue = json['guidValue'];
    maxTextValue = json['maxTextValue'];
//    List json = jsonDecode(data.items[0].fieldValues[1].maxTextValue);
//    print('图片路径：'+json[0]['webUrl']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldId'] = this.fieldId;
    data['indexTextValue'] = this.indexTextValue;
    data['numberValue'] = this.numberValue;
    data['dateTimeValue'] = this.dateTimeValue;
    data['booleanValue'] = this.booleanValue;
    data['guidValue'] = this.guidValue;
    data['maxTextValue'] = this.maxTextValue;
    return data;
  }
}

class Editor {
  String userName;
  String fullName;
  String email;
  String phoneNumber;
  String id;

  Editor({this.userName, this.fullName, this.email, this.phoneNumber, this.id});

  Editor.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['id'] = this.id;
    return data;
  }
}