
class OrganizationUnit {
  Map<String, dynamic> extraProperties;
  String id;
  String parentId;
  String code;
  String displayName;
  int childrenCount;
  bool isActive;

  OrganizationUnit({this.extraProperties, this.id, this.parentId, this.code, this.displayName, this.childrenCount, this.isActive});

  OrganizationUnit.fromJson(Map<String, dynamic> json) {
    extraProperties = json['extraProperties'];
    id = json['id'];
    parentId = json['parentId'];
    code = json['code'];
    displayName = json['displayName'];
    childrenCount = json['childrenCount'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['extraProperties'] = this.extraProperties;
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['code'] = this.code;
    data['displayName'] = this.displayName;
    data['childrenCount'] = this.childrenCount;
    data['isActive'] = this.isActive;
    return data;
  }
}
