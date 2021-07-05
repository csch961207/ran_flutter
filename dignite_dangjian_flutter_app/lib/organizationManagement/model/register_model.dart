class Register {
  String userName;
  String password;
  Edit edit;

  Register({this.userName, this.password, this.edit});

  Register.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    edit = json['edit'] != null ? new Edit.fromJson(json['edit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    if (this.edit != null) {
      data['edit'] = this.edit.toJson();
    }
    return data;
  }
}

class Edit {
  String name;
  String organizationUnitId;

  Edit({this.name, this.organizationUnitId});

  Edit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    organizationUnitId = json['organizationUnitId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['organizationUnitId'] = this.organizationUnitId;
    return data;
  }
}