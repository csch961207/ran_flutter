
class PopularTagsList {
  int totalCount;
  List<PopularTag> items;

  PopularTagsList({this.items});

  PopularTagsList.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = new List<PopularTag>();(json['items'] as List).forEach((v) { items.add(new PopularTag.fromJson(v)); });
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


class PopularTag {
  String name;
  String description;
  int usageCount;
  String icon;
  String id;

  PopularTag(
      {this.name, this.description, this.usageCount, this.icon, this.id});

  PopularTag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    usageCount = json['usageCount'];
    icon = json['icon'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['usageCount'] = this.usageCount;
    data['icon'] = this.icon;
    data['id'] = this.id;
    return data;
  }
}