import 'package:flutter/material.dart';
import 'package:ran_flutter_assets/assets_repository.dart';

import 'package:ran_flutter_assets/model/file_model.dart';

typedef AsyncFileItemWidgetBuilder<T> = Widget Function(
    BuildContext context, FileItem fileItem);

//根据id获取文件数据
class GetAssetsFileItemWidget extends StatelessWidget {
  String fileId;
  AsyncFileItemWidgetBuilder<FileItem> builder;
  GetAssetsFileItemWidget(this.fileId, {Key key, @required this.builder});

  Future<FileItem> getFileItem() async {
    FileItem fileItem = await AssetsRepository.fetchFileItem(fileId);
    return fileItem;
  }

  @override
  Widget build(BuildContext context) {
    print('------#####------');
    print(fileId);
    print('------#####------');
    return FutureBuilder(
        future: AssetsRepository.fetchFileItem(fileId),
        builder: (BuildContext context, AsyncSnapshot<FileItem> snapshot) {
          print('------#####------');
          print(fileId);
          print('------#####------');
          if (snapshot.hasData) {
            return builder(context, snapshot.data);
          } else {
            return Container();
          }
        });
  }
}
