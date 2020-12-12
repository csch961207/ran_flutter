import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/message_provider.dart';
import 'package:ran_flutter_message/model/message_lists_model.dart';
import 'package:ran_flutter_message/model/message_content_model.dart';
import 'package:provider/provider.dart';
import 'package:ran_flutter_message/widgets/group/message_list_group_model.dart';

class MessageListGroupWidget extends StatelessWidget {
  const MessageListGroupWidget({
    Key key,
    @required this.messagesGroup,
  }) : super(key: key);

  final MessagesGroupItem messagesGroup;

  @override
  Widget build(BuildContext context) {
    CurrentUser currentGroup =
        Provider.of<CoreViewModel>(context, listen: false)
            .applicationConfiguration
            .currentUser;
    return new Container(
      height: 66,
      padding: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: LoadImage('',
                    height: 45.0,
                    width: 45.0,
                    fit: BoxFit.fill,
                    holderImg: 'group')),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Text(
                        messagesGroup?.receiverName ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Text(
                        RelativeDateFormat.format(
                            DateTime.parse(messagesGroup.sendTime)),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      margin: EdgeInsets.only(right: 15),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Stack(children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.only(right: 35),
                      child:
                          MessageProvider.getMessageListContentProviderWidget(
                              MessageContentModel.fromJson(
                                  messagesGroup.content)),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: messagesGroup.count == 0 ||
                                currentGroup.id == messagesGroup.senderId
                            ? Container()
                            : Container(
                                padding: EdgeInsets.all(1),
                                margin: EdgeInsets.only(right: 15),
                                width: messagesGroup.count <= 99 ? 18 : 30,
                                height: 18,
                                decoration: new BoxDecoration(
                                  border: new Border.all(
                                      color: Colors.red, width: 0.5), // 边色与边宽度
                                  color: Colors.red, // 底色
                                  //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
//                                            shape: BoxShape.circle, // 默认值也是矩形
                                  borderRadius:
                                      new BorderRadius.circular((20.0)), // 圆角度
                                ),
                                child: Center(
                                  child: Text(
                                    messagesGroup.count <= 99
                                        ? messagesGroup.count.toString()
                                        : messagesGroup.count.toString() + '+',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ))
                  ]),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 0.5,
                      color: Color(0xffE5E5E5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget getMessageListGroupWidgetBuild(MessageLists messageLists) {
  return MessageListGroupWidget(
    messagesGroup: MessagesGroupItem.fromJson(messageLists.messageList),
  );
}
