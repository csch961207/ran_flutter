import 'package:ran_flutter_core/ran_flutter_core.dart';

class UploadFileListModel {
  File file;
  bool isUploading;
  bool isComplete;
  bool isFail;

  UploadFileListModel({this.file,this.isComplete,this.isFail,this.isUploading});

  UploadFileListModel.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    isUploading = json['isUploading'];
    isComplete = json['isComplete'];
    isFail = json['isFail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['isUploading'] = this.isUploading;
    data['isComplete'] = this.isComplete;
    data['isFail'] = this.isFail;
    return data;
  }
}