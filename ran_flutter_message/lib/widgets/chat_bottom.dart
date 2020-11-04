import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/model/chat_message_edit.dart';
import 'package:ran_flutter_message/widgets/emoji_widget.dart';
import 'package:ran_flutter_message/widgets/image_button.dart';

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

  FocusNode focusNode = FocusNode();

  TextEditingController mEditController = TextEditingController();

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
      setState(() {
        _softKeyHeight = keyHeight;
      });
      print("键盘高度是:" + _softKeyHeight.toString());
    } else {}
  }

  @override
  dispose() {
    super.dispose();
    _keyboardVisibility.dispose();
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
        print('键盘是否关闭');
        print(visible);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
//    requestPermission();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
//              buildLeftButton(),
              Expanded(child: buildInputButton()),
//              buildEmojiButton(),
            ],
          ),
          _buildBottomItems(),
        ],
      ),
    );
  }

  Widget _buildBottomItems() {
    return Container(
      height: _softKeyHeight,
    );
//    if (this.mCurrentType == "extra") {
//      return Visibility(
//          visible: mAddLayoutShow,
//          child: Container()
////          new DefaultExtraWidget(onImageSelectBack: (value) {
////            widget.onImageSelectCallBack?.call(value);
////          })
//      );
//    } else if (mCurrentType == "emoji") {
//      return Visibility(
//        visible: mEmojiLayoutShow,
//        child: EmojiWidget(onEmojiClockBack: (value) {
//          if (0 == value) {
//            mEditController.clear();
//          } else {
//            mEditController.text =
//                mEditController.text + String.fromCharCode(value);
//          }
//        }),
//      );
//    } else {
//      return Container(
//        height: _softKeyHeight,
//      );
//    }
  }

  Widget buildInputButton() {
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
          fillColor: Color.fromRGBO(238, 239, 243, 1),
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
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Stack(
        textDirection: TextDirection.rtl,
        children: <Widget>[
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

