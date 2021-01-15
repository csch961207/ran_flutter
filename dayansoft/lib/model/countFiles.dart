class CountFiles {
  int countFiles;
  int code;

  CountFiles({this.countFiles, this.code});

  CountFiles.fromJson(Map<String, dynamic> json) {
    countFiles = json['countFiles'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countFiles'] = this.countFiles;
    data['code'] = this.code;
    return data;
  }
}