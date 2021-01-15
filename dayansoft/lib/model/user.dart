class User {
  int userId;
  String nowTime;
  String userName;
  int code;
  int dealerShipId;

  User(
      {this.userId, this.nowTime, this.userName, this.code, this.dealerShipId});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    nowTime = json['NowTime'];
    userName = json['userName'];
    code = json['code'];
    dealerShipId = json['dealerShipId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['NowTime'] = this.nowTime;
    data['userName'] = this.userName;
    data['code'] = this.code;
    data['dealerShipId'] = this.dealerShipId;
    return data;
  }
}
