import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/model/chat_message.dart';
import 'package:ran_flutter_message/model/chat_message_edit.dart';
import 'package:ran_flutter_message/model/message_content_type_model.dart';
import 'package:ran_flutter_message/view_model/message_model.dart';
import 'package:ran_flutter_message/widgets/emoji_widget.dart';
import 'package:ran_flutter_message/widgets/extra_widget.dart';
import 'package:ran_flutter_message/widgets/image_button.dart';
import 'package:ran_flutter_message/widgets/record_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

String _initType = "text";

typedef void OnSendMessage(ChatMessageEdit chatMessageEdit);

class ChatBottomInputWidget extends StatefulWidget {
  final OnSendMessage onSendMessageCallBack;

  final Stream shouldTriggerChange;

  const ChatBottomInputWidget(
      {Key key, @required this.shouldTriggerChange, this.onSendMessageCallBack})
      : super(key: key);

  @override
  _ChatBottomInputWidgetState createState() => _ChatBottomInputWidgetState();
}

class _ChatBottomInputWidgetState extends State<ChatBottomInputWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  String mCurrentType = _initType;

  bool mBottomLayoutShow = false;

  bool mAddLayoutShow = false;

  bool mEmojiLayoutShow = false;

  final GlobalKey globalKey = GlobalKey();

  void _getWH() {
    if (globalKey == null) return;
    if (globalKey.currentContext == null) return;
    if (globalKey.currentContext.size == null) return;
  }

  FocusNode focusNode = FocusNode();

  TextEditingController mEditController = TextEditingController();

  String lastText = '';

  StreamController<String> inputContentStreamController =
      StreamController.broadcast();

  Stream<String> get inputContentStream => inputContentStreamController.stream;

  double _softKeyHeight = 0;
  int subscribeId;

  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();

  @override
  void didChangeMetrics() {
    final mediaQueryData = MediaQueryData.fromWindow(ui.window);
    final keyHeight = mediaQueryData?.viewInsets?.bottom;
    if (keyHeight != 0) {
      if (mounted) {
        setState(() {
          _softKeyHeight = keyHeight;
        });
      }
      print("键盘高度是:" + _softKeyHeight.toString());
    } else {}
  }

  @override
  dispose() {
    super.dispose();
    _keyboardVisibility.dispose();
    mEditController.dispose();
    focusNode.dispose();
    inputContentStream.distinct();
    inputContentStreamController.close();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    mEditController.addListener(() {
      inputContentStreamController.add(mEditController.text);
    });
    _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        print('键盘是否可见');
        print(visible);
        if (!visible) {
          setState(() {
            _softKeyHeight = 0;
          });
        }
      },
    );
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        //有焦点
        mCurrentType = "text";
      } else {
        //失去焦点
        FocusScope.of(context).unfocus();
      }
    });
  }

  Future requestPermission() async {
    // 申请权限
//    Map<PermissionGroup, PermissionStatus> permissions =
//    await PermissionHandler().requestPermissions(
//        [PermissionGroup.storage, PermissionGroup.microphone]);
//
//    // 申请结果
//
//    PermissionStatus permission = await PermissionHandler()
//        .checkPermissionStatus(PermissionGroup.storage);
//
//    if (permission == PermissionStatus.granted) {
//      //  Fluttertoast.showToast(msg: "权限申请通过");
//
//    } else {
//      //Fluttertoast.showToast(msg: "权限申请被拒绝");
//
//    }
  }

  @override
  Widget build(BuildContext context) {
//    requestPermission();
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(246, 246, 246, 1),
        border: Border(
          top: BorderSide(
              // 设置单侧边框的样式
              color: Color.fromRGBO(219, 219, 219, 1),
              width: 0.5,
              style: BorderStyle.solid),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              buildLeftButton(),
              Expanded(child: buildInputButton()),
              buildEmojiButton(),
              buildRightButton(),
            ],
          ),
          _buildBottomItems(),
        ],
      ),
    );
  }

  Widget buildRightButton() {
    return ImageButton(
        image: new AssetImage('packages/ran_flutter_message/' +
            ImageHelper.wrapAssets("ic_add.png")),
        onPressed: () {
          FocusScope.of(context).unfocus();
          this.mCurrentType = "extra";
          if (focusNode.hasFocus) {
            hideSoftKey();
            Future.delayed(const Duration(milliseconds: 50), () {
              setState(() {
                mBottomLayoutShow = true;
                mAddLayoutShow = true;
              });
            });
          } else {
            showSoftKey();
            mBottomLayoutShow = true;
            mAddLayoutShow = false;
            setState(() {});
          }
        });
  }

  Widget buildLeftButton() {
    return mCurrentType == "voice" ? mKeyBoardButton() : mRecordButton();
  }

  Widget mRecordButton() {
    return new ImageButton(
      onPressed: () {
        this.mCurrentType = "voice";
        hideSoftKey();
        mBottomLayoutShow = false;
        mEmojiLayoutShow = false;
        setState(() {});
      },
      image: new AssetImage('packages/ran_flutter_message/' +
          ImageHelper.wrapAssets("ic_audio.png")),
    );
  }

  Widget mKeyBoardButton() {
    return new ImageButton(
      onPressed: () {
        this.mCurrentType = "text";
        showSoftKey();
        setState(() {});
      },
      image: new AssetImage('packages/ran_flutter_message/' +
          ImageHelper.wrapAssets('ic_keyboard.png')),
    );
  }

  Widget buildEmojiButton() {
    return mCurrentType != "emoji" ? mEmojiButton() : mEmojiKeyBoardButton();
  }

  Widget mEmojiButton() {
    return new ImageButton(
        onPressed: () {
          lastText = mEditController.text;
          this.mCurrentType = "emoji";
          _getWH();
          setState(() {
            mBottomLayoutShow = true;
            mEmojiLayoutShow = true;
          });
          hideSoftKey();
        },
        image: new AssetImage('packages/ran_flutter_message/' +
            ImageHelper.wrapAssets("ic_emoji.png")));
  }

  Widget mEmojiKeyBoardButton() {
    return new ImageButton(
      onPressed: () {
        _getWH();
        this.mCurrentType = "text";
        mBottomLayoutShow = true;
        mEmojiLayoutShow = false;
        setState(() {});
        showSoftKey();
      },
      image: new AssetImage('packages/ran_flutter_message/' +
          ImageHelper.wrapAssets('ic_keyboard.png')),
    );
  }

  Widget _buildBottomItems() {
    if (this.mCurrentType == "extra") {
      return Container(
        height: 200,
        child: Visibility(
            visible: mAddLayoutShow,
            child: DefaultExtraWidget(
              onPressed: (result) {
//                print('-----------------');
//                print(result);
//                print('-----------------');
//                return;
                MessageContentType messageContentType =
                    Provider.of<MessageModel>(context, listen: false)
                        .getMessageContentType(result["contentTypeName"]);
                result["assemblyNameAndTypeName"] =
                    messageContentType.assemblyNameAndTypeName;
                MessageModel messageModel =
                    Provider.of<MessageModel>(context, listen: false);
                ChatMessageEdit chatMessageEdit = ChatMessageEdit(
                    messageId: Uuid().v1(),
                    receiverId:
                        messageModel.currentMessageData.receiverType == 1
                            ? messageModel.currentMessageData.receiverId
                            : messageModel.currentMessageData.senderId,
                    receiverType: messageModel.currentMessageData.receiverType,
                    sendTime: new DateTime.now().toString(),
                    content: json.encode(result));
                if (Provider.of<MessageModel>(context, listen: false)
                        .currentMessageData
                        .receiverType ==
                    1) {
                  Provider.of<MessageModel>(context, listen: false)
                      .sendMessageToGroup(chatMessageEdit);
                } else {
                  Provider.of<MessageModel>(context, listen: false)
                      .sendMsg(chatMessageEdit);
                }
              },
            )),
      );
    } else if (mCurrentType == "emoji") {
      return Container(
        height: 200,
        child: Visibility(
          visible: mEmojiLayoutShow,
          child: EmojiWidget(onEmojiClockBack: (value) {
            mEditController.text =
                mEditController.text + String.fromCharCode(value);
          }),
        ),
      );
    } else {
      return Container(
        height: _softKeyHeight,
      );
    }
  }

  Widget mVoiceButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RecordButton(onAudioCallBack: (value, duration) {
        print(value.path);
//        widget.onAudioCallBack?.call(value, duration);
//        final HrlVoiceMessage mMessgae = new HrlVoiceMessage();
//        mMessgae.uuid = Uuid().v4() + "";
//        mMessgae.msgType = HrlMessageType.voice;
//        mMessgae.isSend = true;
//        mMessgae.path = value.path;
//        mMessgae.duration = duration;
//        mMessgae.state = HrlMessageState.sending;
//        mlistMessage.insert(0, mMessgae);
//        listScrollController.animateTo(0.00,
//            duration: Duration(milliseconds: 1),
//            curve: Curves.easeOut);
//        setState(() {});
//        Future.delayed(new Duration(seconds: 1), () {
//          mMessgae.state = HrlMessageState.send_succeed;
//          setState(() {});
//        })
      }),
    );
  }

  Widget buildInputButton() {
    final voiceButton = mVoiceButton(context);
    final inputButton = Container(
      // height: 40,
      constraints: BoxConstraints(
        maxHeight: 80.0,
        minHeight: 40.0,
      ),
      child: TextField(
        textInputAction: TextInputAction.send,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        //minLines: 1,
        style: TextStyle(fontSize: 16),
        focusNode: focusNode,
        controller: mEditController,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
        ),
        onSubmitted: (text) {
          print('打印');
          if (mEditController.text.trim() == '') {
            ToastUtil.show('消息不能为空');
            return;
          }
          try {
            MessageContentType messageContentType =
                Provider.of<MessageModel>(context, listen: false)
                    .getMessageContentType('text');
            Map<String, Object> content = Map();
            content["contentTypeName"] = messageContentType.contentTypeName;
            content["assemblyNameAndTypeName"] =
                messageContentType.assemblyNameAndTypeName;
            content["content"] = mEditController.text.trim();
            MessageModel messageModel =
                Provider.of<MessageModel>(context, listen: false);
            CurrentUser currentUser =
                Provider.of<CoreViewModel>(context, listen: false)
                    .applicationConfiguration
                    .currentUser;
            ChatMessageEdit chatMessageEdit = ChatMessageEdit(
                messageId: Uuid().v1(),
                receiverId: messageModel.currentMessageData.receiverType == 1
                    ? messageModel.currentMessageData.receiverId
                    : messageModel.currentMessageData.senderId,
                receiverType: messageModel.currentMessageData.receiverType,
                sendTime: new DateTime.now().toString(),
                content: json.encode(content));
            if (Provider.of<MessageModel>(context, listen: false)
                    .currentMessageData
                    .receiverType ==
                1) {
              messageModel.sendMessageToGroup(chatMessageEdit);
            } else {
              messageModel.sendMsg(chatMessageEdit);
            }
            widget.onSendMessageCallBack?.call(chatMessageEdit);
          } catch (e) {
            print(e);
          }
          mEditController.clear();
          this.mCurrentType = "text";
          showSoftKey();
          setState(() {});
        },
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Stack(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Offstage(
            child: voiceButton,
            offstage: mCurrentType != "voice",
          ),
          Offstage(
            child: inputButton,
            offstage: mCurrentType == "voice",
          ),
        ],
      ),
    );
  }

  void showSoftKey() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void hideSoftKey() {
    focusNode.unfocus();
  }
}
