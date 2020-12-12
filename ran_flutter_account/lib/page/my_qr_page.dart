import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ran_flutter_account/account_repository.dart';
import 'package:ran_flutter_account/model/my_profile_model.dart';
import 'package:ran_flutter_account/model/user_model.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';



class MyQrPage extends StatefulWidget {
  @override
  _MyQrPageState createState() => _MyQrPageState();
}

class _MyQrPageState extends State<MyQrPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  MyProfile _myProfile = new MyProfile();

  getMyProfile() async {
    EasyLoading.show();
    try {
      MyProfile myProfile = await AccountRepository.getMyProfile();
      setState(() {
        _myProfile = myProfile;
      });
      EasyLoading.dismiss();
    } catch (e, s) {
      print(e.toString());
      EasyLoading.dismiss();
      getErrorTips(e, s, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser currentUser = Provider.of<CoreViewModel>(context, listen: false)
        .applicationConfiguration
        .currentUser;
    var color = Theme.of(context).accentColor;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的二维码',
          style: TextStyle(color: Colors.black87),
        ),
//        centerTitle: true,
        backgroundColor: Color(0xFFF3F2F2),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Color(0xFFF3F2F2),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            height: height - 300,
            margin: EdgeInsets.fromLTRB(15, 15, 15, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                QrImage(
                  data: json.encode(currentUser), //生成二维码的文字
                  size: 275.0, //生成二维码大小
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(30, 30), //二维码中心图片大小
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
