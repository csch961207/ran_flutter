import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ran_flutter_message/view_model/message_model.dart';
import 'package:ran_flutter_message/widgets/chat_message_item_widget.dart';
import 'package:ran_flutter_message/widgets/expanded_viewport.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController listScrollController = new ScrollController();
  //https://stackoverflow.com/questions/50733840/trigger-a-function-from-a-widget-to-a-state-object/50739019#50739019
  // ignore: close_sinks
  final changeNotifier = new StreamController.broadcast();
  bool isPalyingAudio = false;
  String mPalyingPosition = "";
  bool isShowLoading = false;
  bool isBottomLayoutShowing = false;
  int page = 0;
  int members = 3;
  bool canChat = true;

  @override
  void dispose() {
    super.dispose();
    listScrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageModel>(builder: (context, messageModel, child) {
      listScrollController.addListener(() {
        if (listScrollController.position.pixels ==
            listScrollController.position.maxScrollExtent) {
          messageModel.setBusy();
          setState(() {
            page++;
          });
          if (messageModel.currentMessageData.receiverType == 1) {
            messageModel
                .chatMessagesByGroup(
                    page, messageModel.currentMessageData.receiverId)
                .then((value) {
              messageModel.setSuccessed();
            });
          } else {
            messageModel
                .chatMessagesByUser(
                    page, messageModel.currentMessageData.senderId)
                .then((value) {
              messageModel.setSuccessed();
            });
          }
        }
      });
      return SafeArea(
          child: new WillPopScope(
        onWillPop: () {
          print('走了');
          FocusScope.of(context).requestFocus(FocusNode());
          changeNotifier.sink.add(null);
          Navigator.pop(context);
          if (messageModel.currentMessageData.receiverType == 0) {
            messageModel
                .saveLastReceiveTime(messageModel.currentMessageData.senderId);
          }
          if (messageModel.currentMessageData.receiverType == 1) {
            messageModel.saveLastReceiveTime(
                messageModel.currentMessageData.receiverId);
          }
          return Future.value(false);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
              child: AppBar(
                leading: IconButton(
                    iconSize: 30,
                    icon: Image.asset(
                      'icon_back.png',
                      width: 23.0,
                      height: 23.0,
                    ),
                    onPressed: () {
                      if (messageModel.currentMessageData.receiverType == 0) {
                        messageModel.saveLastReceiveTime(
                            messageModel.currentMessageData.senderId);
                      }
                      if (messageModel.currentMessageData.receiverType == 1) {
                        messageModel.saveLastReceiveTime(
                            messageModel.currentMessageData.receiverId);
                      }
                      Navigator.pop(context);
                    }),
                title: Text(
                  messageModel.currentMessageData.receiverType == 1
                      ? messageModel.currentMessageData.receiverName
                      : messageModel.currentMessageData.senderName,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                elevation: 0.5,
                centerTitle: true,
                actions: <Widget>[],
              ),
              preferredSize: Size.fromHeight(50)),
          backgroundColor: Color.fromRGBO(237, 237, 237, 1),
          body: SafeArea(
              child: Column(
            children: <Widget>[
              /*   Expanded(
          child:Column(
            children: <Widget>[*/
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    //  点击顶部空白处触摸收起键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                    changeNotifier.sink.add(null);
                  },
                  child: new ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: Scrollable(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: listScrollController,
                      axisDirection: AxisDirection.up,
                      viewportBuilder: (context, offset) {
                        return ExpandedViewport(
                          offset: offset,
                          axisDirection: AxisDirection.up,
                          slivers: <Widget>[
                            SliverExpanded(),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (c, i) {
                                  final GlobalKey<ChatMessageItemWidgetState>
                                      mMessageItemKey = GlobalKey();
                                  ChatMessageItemWidget mChatItem =
                                      ChatMessageItemWidget(
                                          key: mMessageItemKey,
                                          chatMessageItem:
                                              messageModel.currentMessages[i]);
                                  return mChatItem;
                                },
                                childCount: messageModel.currentMessages.length,
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: messageModel.loading
                                  ? Container(
                                      margin: EdgeInsets.only(top: 5),
                                      height: 50,
                                      child: Center(
                                        child: SizedBox(
                                          width: 25.0,
                                          height: 25.0,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      ),
                                    )
                                  : new Container(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
//              ChatBottomInputWidget(
//                      message: messageModel.currentMessageData,
//                      shouldTriggerChange: changeNotifier.stream,
//                      onSendMessageCallBack: (value) {
//                        final ChatMessage chatMessgae = new ChatMessage();
//                        chatMessgae.senderId = messageModel.currentMessageData.receiverType == 1
//                            ? user.id
//                            : messageModel.currentMessageData.receiverId;
//                        chatMessgae.receiverId =
//                            messageModel.currentMessageData.receiverType == 1
//                                ? messageModel.currentMessageData.receiverId
//                                : messageModel.currentMessageData.senderId;
//                        chatMessgae.content = value.content;
//                        chatMessgae.sendTime = value.sendTime;
//                        chatMessgae.senderName =
//                            messageModel.currentMessageData.receiverType == 1
//                                ? user.name
//                                : messageModel.currentMessageData.receiverName;
//                        chatMessgae.receiverType = messageModel.currentMessageData.receiverType;
//                        chatMessgae.receiverName =
//                            messageModel.currentMessageData.receiverType == 1
//                                ? messageModel.currentMessageData.receiverName
//                                : messageModel.currentMessageData.senderName;
//
//                        if (messageModel.currentMessageData.receiverType == 1) {
//                          messageModel.sendMessageToGroup(value, chatMessgae);
//                        } else {
//                          messageModel.sendMsg(value, chatMessgae);
//                        }
//                        listScrollController.animateTo(0.00,
//                            duration: Duration(milliseconds: 1),
//                            curve: Curves.easeOut);
//                      },
//                      onSendCallBack: (value) {
//                      },
//                      onImageSelectCallBack: (value) {},
//                      onAudioCallBack: (value, duration) {})
            ],
          )),
        ),
      ));
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}
