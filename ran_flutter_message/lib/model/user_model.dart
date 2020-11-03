class UserModel {
  String mobile;
  int id;
  String headImage;
  String uuid;

  UserModel({
    this.mobile,
    this.id,
    this.headImage,
    this.uuid,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    id = int.parse(json['id']);
    headImage = json['headImage'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['id'] = this.id;
    data['headImage'] = this.headImage;
    data['uuid'] = this.uuid;
    return data;
  }
}
