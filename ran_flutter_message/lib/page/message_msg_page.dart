import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/message_provider.dart';
import 'package:ran_flutter_message/message_router.dart';
import 'package:ran_flutter_message/view_model/message_model.dart';
import 'package:ran_flutter_message/widgets/user/messages_user_model.dart';

class MessageMsgPage extends StatefulWidget {
  @override
  _MessageMsgPageState createState() => _MessageMsgPageState();
}

class _MessageMsgPageState extends State<MessageMsgPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xffffffff),
        child: Consumer<MessageModel>(builder: (context, messageModel, child) {
          if (messageModel.ltMsg.length == 0) {
            return GestureDetector(
              onTap: () {
                messageModel.init();
              },
              child: Center(
                child: Text(
                  '没有数据,点击刷新',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }
          return CustomScrollView(
            slivers: List.generate(messageModel.ltMsg.length + 1, (i) {
              if (i == 0) {
                return SliverToBoxAdapter(
                    child: InkWell(
                  onTap: () {},
                  child: Container(),
                ));
              } else {
                return SliverToBoxAdapter(
                    child: InkWell(
                        onTap: () {
                          print('点击了');
                          MessagesUserItem messagesUserItem =
                              MessagesUserItem.fromJson(
                                  messageModel.ltMsg[i - 1].messageList);
                          messageModel.setCurrentMessageData(
                              messageModel.ltMsg[i - 1].messageList);
                          if (messagesUserItem.receiverType == 1) {
                            Provider.of<MessageModel>(context, listen: false)
                                .chatMessagesByGroup(
                                    0,
                                    MessagesUserItem.fromJson(messageModel
                                            .ltMsg[i - 1].messageList)
                                        .receiverId);
                          } else if (messagesUserItem.receiverType == 0) {

                          } else {

                          }
                          NavigatorUtils.push(context, MessageRouter.chat);
                        },
                        child: MessageProvider.getMessageListsProviderWidget(
                            messageModel.ltMsg[i - 1])));
              }
            }),
          );
        }));
  }
}
