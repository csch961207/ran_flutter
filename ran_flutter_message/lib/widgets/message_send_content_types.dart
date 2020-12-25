import 'package:ran_flutter_assets/ran_flutter_assets.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/model/message_send_content_provider_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class MessageSendContentTypes {
  static String folderToken = '0492ac81ef21450299e6f68c8485bfce';

  static MessageSendContentProviderModel messageSendPictureContentTypeProvider =
      MessageSendContentProviderModel(
          contentTypeName: 'Picture',
          text: '相册',
          leadingIconPath: 'packages/ran_flutter_message/' +
              ImageHelper.wrapAssets('ic_ctype_picture.png'),
          onHandle: () async {
            try {
              PickedFile pickedFile =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              String userId =
                  StorageManager.sharedPreferences.getString("userId");
              EasyLoading.show();
              FileItem file = await AssetsRepository.upload(
                  pickedFile.path, userId, folderToken);
              EasyLoading.dismiss();
              Map<String, Object> result = {
                "contentTypeName": "Picture",
                "webUrl": file.webUrl
              };
              return result;
            } catch (e, s) {
              print(e.toString());
              EasyLoading.dismiss();
            }
            return {};
          });

  static MessageSendContentProviderModel messageSendCameraContentTypeProvider =
      MessageSendContentProviderModel(
          contentTypeName: 'Picture',
          text: '拍照',
          leadingIconPath: 'packages/ran_flutter_message/' +
              ImageHelper.wrapAssets('ic_ctype_camera.png'),
          onHandle: () async {
            try {
              PickedFile pickedFile =
                  await ImagePicker().getImage(source: ImageSource.camera);
              String userId =
                  StorageManager.sharedPreferences.getString("userId");
              EasyLoading.show();
              FileItem file = await AssetsRepository.upload(
                  pickedFile.path, userId, folderToken);
              EasyLoading.dismiss();
              Map<String, Object> result = {
                "contentTypeName": "Picture",
                "webUrl": file.webUrl
              };
              return result;
            } catch (e, s) {
              print(e.toString());
              EasyLoading.dismiss();
            }
            return {};
          });

  static MessageSendContentProviderModel messageSendFileContentTypeProvider =
      MessageSendContentProviderModel(
          contentTypeName: 'File',
          leadingIconPath: 'packages/ran_flutter_message/' +
              ImageHelper.wrapAssets('ic_ctype_file.png'),
          text: '文件',
          onHandle: () async {
            try {
              File fileRes = await FilePicker.getFile(type: FileType.any);
              String userId =
                  StorageManager.sharedPreferences.getString("userId");
              EasyLoading.show();
              FileItem file = await AssetsRepository.upload(
                  fileRes.path, userId, folderToken);
              EasyLoading.dismiss();
              Map<String, Object> result = {
                "contentTypeName": "File",
                "fileId": file.id,
                "fileName": file.name,
                "fileSize": file.size,
              };
              return result;
            } catch (e, s) {
              print(e.toString());
              EasyLoading.dismiss();
            }
            return {};
          });

  static List<MessageSendContentProviderModel> allMessageSendContentTypes = [
    messageSendPictureContentTypeProvider,
    messageSendCameraContentTypeProvider,
    messageSendFileContentTypeProvider
  ];
}
