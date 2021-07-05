import 'organizationUnit_model.dart';

class OrganizationUnitList {
  List<OrganizationUnit> items;

  OrganizationUnitList({this.items});

  OrganizationUnitList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<OrganizationUnit>();
      json['items'].forEach((v) { items.add(new OrganizationUnit.fromJson(v)); });
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