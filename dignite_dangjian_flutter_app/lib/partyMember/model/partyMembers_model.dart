class PartyMember {
  String id;
  String organizationUnitId;
  String organizationUnitName;
  String name;
  int gender;
  String identityNumber;
  String mobileNumber;
  String birthDate;
  String joinDate;
  int partyMemberType;
  String remarks;
  bool isDeparted;
  String departDate;
  int departState;
  String returnDate;
  bool isAudited;
  bool isUploadFace;

  PartyMember(
      {this.id,
        this.organizationUnitId,
        this.organizationUnitName,
        this.name,
        this.gender,
        this.identityNumber,
        this.mobileNumber,
        this.birthDate,
        this.joinDate,
        this.partyMemberType,
        this.remarks,
        this.isDeparted,
        this.departDate,
        this.departState,
        this.returnDate,
        this.isAudited,
        this.isUploadFace});

  PartyMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationUnitId = json['organizationUnitId'];
    organizationUnitName = json['organizationUnitName'];
    name = json['name'];
    gender = json['gender'];
    identityNumber = json['identityNumber'];
    mobileNumber = json['mobileNumber'];
    birthDate = json['birthDate'];
    joinDate = json['joinDate'];
    partyMemberType = json['partyMemberType'];
    remarks = json['remarks'];
    isDeparted = json['isDeparted'];
    departDate = json['departDate'];
    departState = json['departState'];
    returnDate = json['returnDate'];
    isAudited = json['isAudited'];
    isUploadFace = json['isUploadFace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['organizationUnitId'] = this.organizationUnitId;
    data['organizationUnitName'] = this.organizationUnitName;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['identityNumber'] = this.identityNumber;
    data['mobileNumber'] = this.mobileNumber;
    data['birthDate'] = this.birthDate;
    data['joinDate'] = this.joinDate;
    data['partyMemberType'] = this.partyMemberType;
    data['remarks'] = this.remarks;
    data['isDeparted'] = this.isDeparted;
    data['departDate'] = this.departDate;
    data['departState'] = this.departState;
    data['returnDate'] = this.returnDate;
    data['isAudited'] = this.isAudited;
    data['isUploadFace'] = this.isUploadFace;
    return data;
  }
}