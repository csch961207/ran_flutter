class NowTime {
  String nowTime;

  NowTime({this.nowTime});

  NowTime.fromJson(Map<String, dynamic> json) {
    nowTime = json['NowTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NowTime'] = this.nowTime;
    return data;
  }
}
