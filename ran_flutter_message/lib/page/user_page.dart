import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:provider/provider.dart';
import 'package:ran_flutter_message/message_router.dart';
import 'package:ran_flutter_message/view_model/message_model.dart';
import 'package:ran_flutter_message/widgets/user/messages_user_model.dart';

class UserPage extends StatefulWidget {
  final CurrentUser currentUser;
  UserPage({Key key, this.currentUser}) : super(key: key);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.currentUser == null) {
      ToastUtil.show('请扫描个人二维码');
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser currentUser = Provider.of<CoreViewModel>(context, listen: false)
        .applicationConfiguration
        .currentUser;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "用户信息",
        ),
      ),
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClickItem(
                    title: "用户名",
                    content: widget.currentUser?.userName ?? '',
                    onTap: () {
                      try {
                        Clipboard.setData(ClipboardData(
                            text: widget.currentUser?.userName ?? ''));
                        ToastUtil.show('复制成功');
                      } catch (e) {
                        print(e);
                        ToastUtil.show('复制失败');
                      }
                    },
                  ),
                  ClickItem(
                    title: "电子邮箱",
                    content: widget.currentUser?.email ?? '',
                    onTap: () {
                      try {
                        Clipboard.setData(ClipboardData(
                            text: widget.currentUser?.email ?? ''));
                        ToastUtil.show('复制成功');
                      } catch (e) {
                        print(e);
                        ToastUtil.show('复制失败');
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(45, 5, 45, 45),
              child: RanButton(
                text: widget.currentUser == null ? '返回' : '发消息',
                isShape: true,
                onPressed: () async {
                  if (widget.currentUser == null) {
                    NavigatorUtils.goBack(context);
                  }
                  if (currentUser.id != widget.currentUser.id) {
                    Provider.of<MessageModel>(context, listen: false)
                        .setCurrentMessageData({
                      "receiverType": 0,
                      "receiverName": currentUser.userName,
                      "receiverId": currentUser.id,
                      "senderId": widget.currentUser.id,
                      "senderName": widget.currentUser.userName
                    });
                    Provider.of<MessageModel>(context, listen: false)
                        .saveLastReceiveTime(widget.currentUser.id,
                            receiveId: currentUser.id);
                    Provider.of<MessageModel>(context, listen: false)
                        .chatMessagesByUser(0, widget.currentUser.id);
                    NavigatorUtils.goBack(context);
                    NavigatorUtils.pushResult(
                        context, MessageRouter.chat, (result) {});
                  } else {
                    ToastUtil.show('这是我自己');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
