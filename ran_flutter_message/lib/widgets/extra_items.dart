import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/widgets/extra_item.dart';

class ExtraItems {

//发送类型、处理事件
  static ExtraItemContainer createPictureItem() => ExtraItemContainer(
        leadingIconPath: 'packages/ran_flutter_message/' +
            ImageHelper.wrapAssets('ic_ctype_picture.png'),
        text: "相册",
        onTab: () {
//      Future<File> imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
//      imageFile.then((result) {
//        widget.onImageSelectBack?.call(result);
//      });
        },
      );

  static ExtraItemContainer createCameraItem() => ExtraItemContainer(
        leadingIconPath: 'packages/ran_flutter_message/' +
            ImageHelper.wrapAssets('ic_ctype_camera.png'),
        text: "拍照",
        onTab: () {
//      Future<File> imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
//      imageFile.then((result) {
//        widget.onImageSelectBack?.call(result);
//      });
        },
      );

  static ExtraItemContainer createVideoItem() => ExtraItemContainer(
        leadingIconPath: 'packages/ran_flutter_message/' +
            ImageHelper.wrapAssets('ic_ctype_video.png'),
        text: "视频",
        onTab: () {
          print("添加");
        },
      );

  static ExtraItemContainer createVideoCameraItem() => ExtraItemContainer(
        leadingIconPath: 'packages/ran_flutter_message/' +
            ImageHelper.wrapAssets('ic_ctype_video_camera.png'),
        text: "摄像",
        onTab: () {
          print("添加");
        },
      );

  static ExtraItemContainer createFileItem() => ExtraItemContainer(
        leadingIconPath: 'packages/ran_flutter_message/' +
            ImageHelper.wrapAssets('ic_ctype_file.png'),
        text: "文件",
        onTab: () {
          print("添加");
        },
      );

  static List<ExtraItemContainer> allExtraItems = [
    createPictureItem(),
    createCameraItem(),
    createVideoItem(),
    createVideoCameraItem(),
    createFileItem(),
    createPictureItem(),
    createCameraItem(),
    createVideoItem(),
    createFileItem(),
    createPictureItem(),
    createCameraItem(),
    createVideoItem(),
    createFileItem()
  ];
}


