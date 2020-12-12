import 'package:ran_flutter_message/model/message_content_provider_model.dart';
import 'package:ran_flutter_message/widgets/message_content/picture/message_content_picture_widget.dart';
import 'package:ran_flutter_message/widgets/message_content/picture/message_list_content_picture_widget.dart';
import 'package:ran_flutter_message/widgets/message_content/text/message_content_text_widget.dart';
import 'package:ran_flutter_message/widgets/message_content/text/message_list_content_text_widget.dart';

class MessageContentTypes {
  static MessageContentProviderModel messageContentTextTypeProvider =
      MessageContentProviderModel(
          contentTypeName: 'Text',
          contentTypeListWidget: getMessageListContentTextWidgetBuild,
          contentTypeWidget: getMessageContentTextWidgetBuild);

  static MessageContentProviderModel messageContentPictureTypeProvider =
      MessageContentProviderModel(
          contentTypeName: 'Picture',
          contentTypeListWidget: getMessageListContentPictureWidgetBuild,
          contentTypeWidget: getMessageContentPictureWidgetBuild);

  static List<MessageContentProviderModel> allMessageContentTypes = [
    messageContentTextTypeProvider,
    messageContentPictureTypeProvider
  ];
}
