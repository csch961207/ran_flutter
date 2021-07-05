class MyOrganization {
  String id;
  String creationTime;
  String creatorId;
  String userId;
  String name;
  String organizationUnitId;
  String organizationUnitName;
  bool isAudit;

  MyOrganization(
      {this.id,
        this.creationTime,
        this.creatorId,
        this.userId,
        this.name,
        this.organizationUnitId,
        this.organizationUnitName,
        this.isAudit});

  MyOrganization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationTime = json['creationTime'];
    creatorId = json['creatorId'];
    userId = json['userId'];
    name = json['name'];
    organizationUnitId = json['organizationUnitId'];
    organizationUnitName = json['organizationUnitName'];
    isAudit = json['isAudit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['organizationUnitId'] = this.organizationUnitId;
    data['organizationUnitName'] = this.organizationUnitName;
    data['isAudit'] = this.isAudit;
    return data;
  }
}
