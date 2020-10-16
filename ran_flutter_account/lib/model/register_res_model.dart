class RegisterRes {
  String tenantId;
  String userName;
  String name;
  String surname;
  String email;
  bool emailConfirmed;
  String phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  bool lockoutEnabled;
  String lockoutEnd;
  String concurrencyStamp;
  bool isDeleted;
  String deleterId;
  String deletionTime;
  String lastModificationTime;
  String lastModifierId;
  String creationTime;
  String creatorId;
  String id;

  RegisterRes(
      {this.tenantId,
      this.userName,
      this.name,
      this.surname,
      this.email,
      this.emailConfirmed,
      this.phoneNumber,
      this.phoneNumberConfirmed,
      this.twoFactorEnabled,
      this.lockoutEnabled,
      this.lockoutEnd,
      this.concurrencyStamp,
      this.isDeleted,
      this.deleterId,
      this.deletionTime,
      this.lastModificationTime,
      this.lastModifierId,
      this.creationTime,
      this.creatorId,
      this.id});

  RegisterRes.fromJson(Map<String, dynamic> json) {
    tenantId = json['tenantId'];
    userName = json['userName'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    emailConfirmed = json['emailConfirmed'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnabled = json['lockoutEnabled'];
    lockoutEnd = json['lockoutEnd'];
    concurrencyStamp = json['concurrencyStamp'];
    isDeleted = json['isDeleted'];
    deleterId = json['deleterId'];
    deletionTime = json['deletionTime'];
    lastModificationTime = json['lastModificationTime'];
    lastModifierId = json['lastModifierId'];
    creationTime = json['creationTime'];
    creatorId = json['creatorId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenantId'] = this.tenantId;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['emailConfirmed'] = this.emailConfirmed;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['lockoutEnabled'] = this.lockoutEnabled;
    data['lockoutEnd'] = this.lockoutEnd;
    data['concurrencyStamp'] = this.concurrencyStamp;
    data['isDeleted'] = this.isDeleted;
    data['deleterId'] = this.deleterId;
    data['deletionTime'] = this.deletionTime;
    data['lastModificationTime'] = this.lastModificationTime;
    data['lastModifierId'] = this.lastModifierId;
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['id'] = this.id;
    return data;
  }
}
