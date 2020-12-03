import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_assets/assets_repository.dart';
import 'package:ran_flutter_assets/model/file_model.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bot_toast/bot_toast.dart';

/// 上传单个文件封装
class RanUploadSingleFile extends StatefulWidget {
  const RanUploadSingleFile({
    Key key,
    this.fileId,
    this.providerKey,
    this.folderToken,
    this.defaultText,
    this.fileItem,
    this.onPressed,
  }) : super(key: key);

  final String fileId;
  final String providerKey;
  final String folderToken;
  final String defaultText;
  final FileItem fileItem;
  final Function(FileItem) onPressed;

  @override
  _RanUploadSingleFileState createState() => _RanUploadSingleFileState();
}

class _RanUploadSingleFileState extends State<RanUploadSingleFile> {
  FileItem fileItem = new FileItem();
  @override
  void initState() {
    super.initState();
    fileItem = widget.fileItem;
    getFileItem();
  }

  getFileItem() async {
    if (widget.fileId != null) {
      try {
        FileItem fileItemRes =
            await AssetsRepository.fetchFileItem(widget.fileId);
        setState(() {
          fileItem = fileItemRes;
        });
      } catch (e, s) {
        print(e.toString());
        setState(() {
          fileItem = new FileItem(id: widget.fileId, name: '文件查找发生错误');
        });
//        getErrorTips(e, s, context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(
            left: 16.0, top: 8.0, bottom: 8.0, right: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            Image.asset(
              'packages/ran_flutter_assets/' +
                  ImageHelper.wrapAssets('excel.png'),
              width: 30,
              height: 30,
              fit: BoxFit.fitWidth,
              colorBlendMode: BlendMode.srcIn,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fileItem?.name ?? widget.defaultText),
              ],
            )),
            SizedBox(
              width: 10,
            ),
            fileItem?.id != null
                ? InkWell(
                    onTap: () async {
                      showElasticDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return BaseDialog(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: const Text("你确定要删除吗",
                                    textAlign: TextAlign.center),
                              ),
                              onPressed: () async {
                                NavigatorUtils.goBack(context);
                                EasyLoading.show();
                                try {
                                  var code = await AssetsRepository.deleteFile(
                                      fileItem.id);
                                  if (code == 204 || code == 200) {
                                    setState(() {
                                      fileItem = new FileItem();
                                    });
                                    widget.onPressed(fileItem);
                                  }
                                  EasyLoading.dismiss();
                                } catch (e, s) {
                                  EasyLoading.dismiss();
                                  print(e.toString());
                                  setState(() {
                                    fileItem = new FileItem();
                                  });
                                  widget.onPressed(fileItem);
//                                  getErrorTips(e, s, context: context);
                                }
                              },
                            );
                          });
                    },
                    child: Icon(CupertinoIcons.delete))
                : Icon(CupertinoIcons.upload_circle),
          ],
        ),
      ),
      onTap: () async {
        if (fileItem?.id != null) {
          return;
        }
        File fileRes = await FilePicker.getFile(
            type: FileType.custom,
            allowedExtensions: ['xls', 'xlsx', 'csv', 'pdf']);
        if (fileRes != null) {
          EasyLoading.show();
          try {
            FileItem file = await AssetsRepository.upload(
                fileRes, widget.providerKey, widget.folderToken);
            setState(() {
              fileItem = file;
            });
            widget.onPressed(fileItem);
            EasyLoading.dismiss();
          } catch (e, s) {
            print(e.toString());
            EasyLoading.dismiss();
            getErrorTips(e, s, context: context);
          }
        }
      },
    );
  }
}
