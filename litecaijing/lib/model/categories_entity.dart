class CategoriesEntity {
  List<CategoryItem> items;

  CategoriesEntity({this.items});

  CategoriesEntity.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<CategoryItem>();(json['items'] as List).forEach((v) { items.add(new CategoryItem.fromJson(v)); });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] =  this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class CategoryItem {
  String id;
  String mediaTypeName;
  String parentId;
  String code;
  String name;

  CategoryItem(
      {this.id, this.mediaTypeName, this.parentId, this.code, this.name});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaTypeName = json['mediaTypeName'];
    parentId = json['parentId'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mediaTypeName'] = this.mediaTypeName;
    data['parentId'] = this.parentId;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}