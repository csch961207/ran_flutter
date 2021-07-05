class AddPartyMember {
  String organizationUnitId;
  PartyMemberEdit edit;

  AddPartyMember({this.organizationUnitId, this.edit});

  AddPartyMember.fromJson(Map<String, dynamic> json) {
    organizationUnitId = json['organizationUnitId'];
    edit = json['edit'] != null ? new PartyMemberEdit.fromJson(json['edit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organizationUnitId'] = this.organizationUnitId;
    if (this.edit != null) {
      data['edit'] = this.edit.toJson();
    }
    return data;
  }
}

class PartyMemberEdit {
  String name;
  int gender;
  String identityNumber;
  String mobileNumber;
  String birthDate;
  String joinDate;
  int partyMemberType;
  String remarks;

  PartyMemberEdit(
      {this.name,
        this.gender,
        this.identityNumber,
        this.mobileNumber,
        this.birthDate,
        this.joinDate,
        this.partyMemberType,
        this.remarks});

  PartyMemberEdit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
    identityNumber = json['identityNumber'];
    mobileNumber = json['mobileNumber'];
    birthDate = json['birthDate'];
    joinDate = json['joinDate'];
    partyMemberType = json['partyMemberType'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['identityNumber'] = this.identityNumber;
    data['mobileNumber'] = this.mobileNumber;
    data['birthDate'] = this.birthDate;
    data['joinDate'] = this.joinDate;
    data['partyMemberType'] = this.partyMemberType;
    data['remarks'] = this.remarks;
    return data;
  }
}