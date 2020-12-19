import 'package:ran_flutter_site/model/section_model.dart';

class Entities {
  int totalCount;
  List<Entity> items;

  Entities({this.totalCount, this.items});

  Entities.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = new List<Entity>();
      json['items'].forEach((v) {
        items.add(new Entity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Entity {
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
  List<FieldValue> fieldValues;
  Editor editor;
  String url;
  String creationTime;
  String creatorId;
  String id;

  Entity(
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
        this.url,
        this.creationTime,
        this.creatorId,
        this.id});

  Entity.fromJson(Map<String, dynamic> json) {
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
      fieldValues = new List<FieldValue>();
      json['fieldValues'].forEach((v) {
        fieldValues.add(new FieldValue.fromJson(v));
      });
    }
    editor =
    json['editor'] != null ? new Editor.fromJson(json['editor']) : null;
    url = json['url'];
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
    data['url'] = this.url;
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['id'] = this.id;
    return data;
  }
}

class FieldValue {
  String fieldId;
  String indexTextValue;
  int numberValue;
  String dateTimeValue;
  bool booleanValue;
  String guidValue;
  String maxTextValue;

  FieldValue(
      {this.fieldId,
        this.indexTextValue,
        this.numberValue,
        this.dateTimeValue,
        this.booleanValue,
        this.guidValue,
        this.maxTextValue});

  FieldValue.fromJson(Map<String, dynamic> json) {
    fieldId = json['fieldId'];
    indexTextValue = json['indexTextValue'];
    numberValue = json['numberValue'];
    dateTimeValue = json['dateTimeValue'];
    booleanValue = json['booleanValue'];
    guidValue = json['guidValue'];
    maxTextValue = json['maxTextValue'];
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
  String userId;
  String userName;
  String fullName;

  Editor({this.userId, this.userName, this.fullName});

  Editor.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    return data;
  }
}