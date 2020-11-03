import 'package:ran_flutter_message/model/message_lists_provider_model.dart';
import 'package:ran_flutter_message/widgets/group/message_list_group_widget.dart';
import 'package:ran_flutter_message/widgets/message_app/message_list_message_app_widget.dart';
import 'package:ran_flutter_message/widgets/user/message_list_user_widget.dart';

class MessageListTypes {
  static MessageListsProviderModel messageListUserTypeProvider =
      MessageListsProviderModel(
          messagesTypeName: 'User',
          messagesTypeWidget: getMessageListUserWidgetBuild);

  static MessageListsProviderModel messageListGroupTypeProvider =
      MessageListsProviderModel(
          messagesTypeName: 'Group',
          messagesTypeWidget: getMessageListGroupWidgetBuild);

  static MessageListsProviderModel messageListAppTypeProvider =
      MessageListsProviderModel(
          messagesTypeName: 'MessageApp',
          messagesTypeWidget: getMessageListAppWidgetBuild);

  static List<MessageListsProviderModel> allMessageListTypes = [
    messageListUserTypeProvider,
    messageListGroupTypeProvider,
    messageListAppTypeProvider
  ];
}
