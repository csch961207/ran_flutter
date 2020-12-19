class Blog {
  String name;
  String description;
  String authenticationStatus;
  String background;
//  Null blogger;
  String creationTime;
  String creatorId;
  String id;

  Blog(
      {
        this.name,
        this.description,
        this.authenticationStatus,
        this.background,
//        this.blogger,
        this.creationTime,
        this.creatorId,
        this.id
      });

  Blog.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    authenticationStatus = json['authenticationStatus'];
    background = json['background'];
//    blogger = json['blogger'];
    creationTime = json['creationTime'];
    creatorId = json['creatorId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['authenticationStatus'] = this.authenticationStatus;
    data['background'] = this.background;
//    data['blogger'] = this.blogger;
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['id'] = this.id;
    return data;
  }
}