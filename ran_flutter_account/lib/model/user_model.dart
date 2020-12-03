class User {
  String id;
  String tenantId;
  String userName;
  String name;
  String surname;
  String email;
  bool emailConfirmed;
  String phoneNumber;
  bool phoneNumberConfirmed;

  User(
      {this.id,
        this.tenantId,
        this.userName,
        this.name,
        this.surname,
        this.email,
        this.emailConfirmed,
        this.phoneNumber,
        this.phoneNumberConfirmed});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenantId'];
    userName = json['userName'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    emailConfirmed = json['emailConfirmed'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenantId'] = this.tenantId;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['emailConfirmed'] = this.emailConfirmed;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    return data;
  }
}