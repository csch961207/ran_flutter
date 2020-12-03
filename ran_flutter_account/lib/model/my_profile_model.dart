class MyProfile {
  String userName;
  String email;
  String name;
  String surname;
  String phoneNumber;
  ExtraProperties extraProperties;

  MyProfile(
      {this.userName,
      this.email,
      this.name,
      this.surname,
      this.phoneNumber,
      this.extraProperties});

  MyProfile.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    name = json['name'];
    surname = json['surname'];
    phoneNumber = json['phoneNumber'];
    extraProperties = json['extraProperties'] != null
        ? new ExtraProperties.fromJson(json['extraProperties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['phoneNumber'] = this.phoneNumber;
    if (this.extraProperties != null) {
      data['extraProperties'] = this.extraProperties.toJson();
    }
    return data;
  }
}

class ExtraProperties {
  Map<String, Object> additionalProp1;
  Map<String, Object> additionalProp2;
  Map<String, Object> additionalProp3;

  ExtraProperties(
      {this.additionalProp1, this.additionalProp2, this.additionalProp3});

  ExtraProperties.fromJson(Map<String, dynamic> json) {
    additionalProp1 = json['additionalProp1'];
    additionalProp2 = json['additionalProp2'];
    additionalProp3 = json['additionalProp3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['additionalProp1'] = this.additionalProp1;
    data['additionalProp2'] = this.additionalProp2;
    data['additionalProp3'] = this.additionalProp3;
    return data;
  }
}

class InputMyProfile {
  String userName;
  String email;
  String name;
  String surname;
  String phoneNumber;

  InputMyProfile(
      {this.userName, this.email, this.name, this.surname, this.phoneNumber});

  InputMyProfile.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    name = json['name'];
    surname = json['surname'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
