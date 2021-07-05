import 'package:dignite_dangjian_flutter_app/partyMember/model/add_partyMembers_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_model.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:provider/provider.dart';
import 'package:ran_flutter_core/utils/jhPickerTool.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../partyMember_repository.dart';

class EditPartyMemberPage extends StatefulWidget {
  const EditPartyMemberPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;
  @override
  _EditPartyMemberPageState createState() => _EditPartyMemberPageState();
}

class _EditPartyMemberPageState extends State<EditPartyMemberPage> {
  PartyMemberEdit _addPartyMemberEdit = new PartyMemberEdit();
  Enums genderType = new Enums(enumValues: [
    new EnumValue(name: '女', value: 0),
    new EnumValue(name: '男', value: 1)
  ]);
  Enums partyMemberType = new Enums(enumValues: [
    new EnumValue(name: '在职党员', value: 1),
    new EnumValue(name: '离退休党员', value: 2),
    new EnumValue(name: '年老体弱党员', value: 3),
    new EnumValue(name: '流动党员', value: 4)
  ]);

  final _nameController = TextEditingController();
  final FocusNode _nameNodeText = FocusNode();
  final _identityNumberController = TextEditingController();
  final FocusNode _identityNumberNodeText = FocusNode();
  final _mobileNumberController = TextEditingController();
  final FocusNode _mobileNumberNodeText = FocusNode();
  final _remarksController = TextEditingController();
  final FocusNode _remarksNodeText = FocusNode();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    EasyLoading.show();
    try {
      PartyMember res = await PartyMemberRepository.getPartyMembers(widget.id);
      _addPartyMemberEdit = PartyMemberEdit.fromJson(res.toJson());
      _nameController.text = _addPartyMemberEdit.name;
      _identityNumberController.text = _addPartyMemberEdit.identityNumber;
      _mobileNumberController.text = _addPartyMemberEdit.mobileNumber;
      _remarksController.text = _addPartyMemberEdit.remarks;
      _addPartyMemberEdit.birthDate = _addPartyMemberEdit.birthDate != null
          ? Utils.daysFormat(
          DateTime.parse(_addPartyMemberEdit.birthDate))
          : "";
      _addPartyMemberEdit.joinDate = _addPartyMemberEdit.joinDate != null
          ? Utils.daysFormat(
          DateTime.parse(_addPartyMemberEdit.joinDate))
          : "";
      setState(() {
      });
      EasyLoading.dismiss();
    } catch (e, s) {
      print(e.toString());
      EasyLoading.dismiss();
      getErrorTips(e, s, context: this.context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    String userName = Provider.of<CoreViewModel>(context, listen: false)
        ?.applicationConfiguration
        ?.currentUser
        ?.userName;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '编辑党员信息',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: APPColors.app_main,
        iconTheme: IconThemeData(color: Colors.white),
//        elevation: 1.0,
      ),
      backgroundColor: Color(0xFFF3F2F2),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 16.0),
                      child: const Text("基本信息", style: TextStyle(fontSize: 16)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 15, left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldItem(
                              controller: _nameController,
                              focusNode: _nameNodeText,
                              title: "姓名",
                              hintText: "请输入",
                              isRequired: true),
                          ClickItem(
                            title: "性别",
                            content: genderType
                                .enumName(_addPartyMemberEdit.gender ?? 0),
                            widgetContent: _addPartyMemberEdit.gender == null ? Text("请选择",
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14,color: Colors.grey)): null,
                            onTap: () {
                              JhPickerTool.showStringPicker(context,
                                  data: genderType.enumNameList(),
                                  title: "请选择性别",
                                  normalIndex: genderType.enumValues.indexWhere(
                                          (e) =>
                                      e.value ==
                                          _addPartyMemberEdit.gender),
                                  clickCallBack: (int index, var str) {
                                    print(index);
                                    print(str);
                                    setState(() {
                                      _addPartyMemberEdit.gender =
                                          genderType.enumValues[index].value;
                                    });
                                  });
                            },
                          ),
                          TextFieldItem(
                              controller: _identityNumberController,
                              focusNode: _identityNumberNodeText,
                              title: "身份证号",
                              hintText: "请输入"),
                          TextFieldItem(
                            keyboardType: TextInputType.phone,
                              controller: _mobileNumberController,
                              focusNode: _mobileNumberNodeText,
                              title: "手机号",
                              hintText: "请输入"),
                          ClickItem(
                            title: "出生日期",
                            content: _addPartyMemberEdit.birthDate ?? "",
                            widgetContent: _addPartyMemberEdit.birthDate == null ? Text("请选择",
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14,color: Colors.grey)): null,
                            onTap: () {
                              JhPickerTool.showDatePicker(context,
                                  dateType: DateType.YMD,
                                  title: "请选择出生日期",
                                  value: DateTime(
                                      new DateTime.now().year,
                                      new DateTime.now().month,
                                      new DateTime.now().day),
                                  clickCallback: (var str, var time, var year,
                                      var month, var item) {
                                    print(str);
                                    print(time);
                                    print(year);
                                    print(month);
                                    print(item);
                                    setState(() {
                                      _addPartyMemberEdit.birthDate = str;
                                    });
                                  });
                            },
                          ),
                          ClickItem(
                            title: "入党时间",
                            content: _addPartyMemberEdit.joinDate ?? '',
                            widgetContent: _addPartyMemberEdit.joinDate == null ? Text("请选择",
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14,color: Colors.grey)): null,
                            onTap: () {
                              JhPickerTool.showDatePicker(context,
                                  dateType: DateType.YMD,
                                  title: "请选择入党时间",
                                  value: DateTime(
                                      new DateTime.now().year,
                                      new DateTime.now().month,
                                      new DateTime.now().day),
                                  clickCallback: (var str, var time, var year,
                                      var month, var item) {
                                    print(str);
                                    print(time);
                                    print(year);
                                    print(month);
                                    print(item);
                                    setState(() {
                                      _addPartyMemberEdit.joinDate = str;
                                    });
                                  });
                            },
                          ),
                          ClickItem(
                            title: "党员状态",
                            content: partyMemberType.enumName(
                                _addPartyMemberEdit.partyMemberType ?? 0),
                            widgetContent: _addPartyMemberEdit.partyMemberType == null ? Text("请选择",
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14,color: Colors.grey)): null,
                            onTap: () {
                              JhPickerTool.showStringPicker(context,
                                  data: partyMemberType.enumNameList(),
                                  title: "请选择党员状态",
                                  normalIndex: partyMemberType.enumValues
                                      .indexWhere((e) =>
                                  e.value ==
                                      _addPartyMemberEdit.partyMemberType),
                                  clickCallBack: (int index, var str) {
                                    print(index);
                                    print(str);
                                    setState(() {
                                      _addPartyMemberEdit.partyMemberType =
                                          partyMemberType.enumValues[index].value;
                                    });
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: const Text("备注", style: TextStyle(fontSize: 16)),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 15,right: 5,left: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
//                      textInputAction: TextInputAction.search,
                          key: const Key('c_text'),
                          controller: _remarksController,
                          focusNode: _remarksNodeText,
                          maxLines: 10,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 5.0, left: 8.0, right: 8.0, bottom: 5.0),
                            border: InputBorder.none,
                            hintText: '请输入内容',
                          ),
                          onChanged: (text) {},
                          onSubmitted: (text) {
                            FocusScope.of(context).unfocus();
                            print('submit $text');
                          },
                        ))
                  ],
                ),
              )),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
            child: RanButton(
              text: '提交',
//                isShape: true,
              onPressed: () async {
                try {
                  if(_nameController.text.isEmpty){
                    ToastUtil.show("姓名为必填项");
                    return;
                  }
                  EasyLoading.show();
                  this._addPartyMemberEdit.name = _nameController.text;
                  this._addPartyMemberEdit.identityNumber =
                      _identityNumberController.text;
                  this._addPartyMemberEdit.mobileNumber =
                      _mobileNumberController.text;
                  this._addPartyMemberEdit.remarks = _remarksController.text;
                  String code = await PartyMemberRepository.putPartyMembers(widget.id,
                      this._addPartyMemberEdit);
                  if (code == "200" || code == "204") {
                    await Provider.of<DangjianViewModel>(context, listen: false)
                        .getPartyMemberList();
                    EasyLoading.dismiss();
                    NavigatorUtils.goBack(context);
                    ToastUtil.show('提交成功');
                  }
                  EasyLoading.dismiss();
                } catch (e, s) {
                  print(e.toString());
                  EasyLoading.dismiss();
                  getErrorTips(e, s, context: context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
