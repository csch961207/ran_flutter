import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_account/account_repository.dart';
import 'package:ran_flutter_account/model/my_profile_model.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_core/widget/text_field_item.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void dispose() {
    super.dispose();
  }

  final _userNameController = TextEditingController();
  final FocusNode _userNameNodeText = FocusNode();
  final _emailController = TextEditingController();
  final FocusNode _emailNoNodeText = FocusNode();
  final _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberNodeText = FocusNode();

  MyProfile _myProfile = new MyProfile();

  getMyProfile() async {
    EasyLoading.show();
    try {
      MyProfile myProfile = await AccountRepository.getMyProfile();
      setState(() {
        _myProfile = myProfile;
        _userNameController.text = myProfile.userName;
        _emailController.text = myProfile.email;
        _phoneNumberController.text = myProfile.phoneNumber;
      });
      EasyLoading.dismiss();
    } catch (e, s) {
      print(e.toString());
      EasyLoading.dismiss();
      getErrorTips(e, s, context: context);
    }
  }

  @override
  void initState() {
    super.initState();
    getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "编辑资料",
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
                  TextFieldItem(
                      controller: _userNameController,
                      focusNode: _userNameNodeText,
                      title: "用户名",
                      hintText: ""),
                  TextFieldItem(
                      controller: _emailController,
                      focusNode: _emailNoNodeText,
                      title: "电子邮箱",
                      hintText: ""),
                  TextFieldItem(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.number,
                      focusNode: _phoneNumberNodeText,
                      title: "手机号",
                      hintText: ""),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(45, 5, 45, 45),
              child: RanButton(
                text: '保存',
                isShape: true,
                onPressed: () async {
                  if (!verification()) {
                    return;
                  }
                  EasyLoading.show();
                  InputMyProfile inputMyProfile = new InputMyProfile(
                      userName: _userNameController.text,
                      email: _emailController.text,
                      phoneNumber: _phoneNumberController.text);
                  var code =
                      await AccountRepository.editMyProfile(inputMyProfile);
                  try {
                    EasyLoading.dismiss();
                    if (code == 200 || code == 204) {
                      NavigatorUtils.goBack(context);
                    }
                  } catch (e, s) {
                    print(e.toString());
                    EasyLoading.dismiss();
                    getErrorTips(e, s, context: context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  bool verification() {
    if (_userNameController.text == null || _userNameController.text == '') {
      ToastUtil.show('请填写用户名称');
      return false;
    }
    if (_emailController.text == null || _emailController.text == '') {
      ToastUtil.show('请填写邮箱地址');
      return false;
    }
    return true;
  }
}
