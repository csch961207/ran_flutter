class MessageApp {
  String appName;
  String name;

  MessageApp({this.appName, this.name});

  MessageApp.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appName'] = this.appName;
    data['name'] = this.name;
    return data;
  }
}