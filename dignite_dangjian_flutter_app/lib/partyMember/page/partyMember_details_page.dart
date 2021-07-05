import 'dart:convert';

import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_model.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../partyMember_repository.dart';
import '../partyMember_router.dart';

class PartyMemberDetailsPage extends StatefulWidget {
  const PartyMemberDetailsPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;
  @override
  _PartyMemberDetailsPageState createState() => _PartyMemberDetailsPageState();
}

class _PartyMemberDetailsPageState extends State<PartyMemberDetailsPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  final picker = ImagePicker();
  PartyMember partyMember = new PartyMember();
  Enums genderType = new Enums(
      enumValues: [new EnumValue(name: '女', value: 0),new EnumValue(name: '男', value: 1)]);
  Enums partyMemberType = new Enums(
      enumValues: [new EnumValue(name: '在职党员', value: 1),new EnumValue(name: '离退休职工党员', value: 2),new EnumValue(name: '年老体弱党员', value: 3),new EnumValue(name: '流动党员', value: 4)]);


  void loadData() async {
    EasyLoading.show();
    try {
      PartyMember res = await PartyMemberRepository.getPartyMembers(widget.id);
      print(partyMember.toJson());
      setState(() {
        partyMember = res;
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
          '党员信息',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: APPColors.app_main,
        iconTheme: IconThemeData(color: Colors.white),
//        elevation: 1.0,
        actions: [
          IconButton(
            tooltip: '更多',
            icon: Icon(
              CupertinoIcons.ellipsis,
              size: 21,
            ),
            color: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,

                /// 使用true则高度不受16分之9的最高限制
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Container(
                    height: 160,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              if (partyMember.isUploadFace == true) {
                                showElasticDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return BaseDialog(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: const Text("你确定要再次已采集吗？",
                                              textAlign: TextAlign.center),
                                        ),
                                        onPressed: () async {
                                          _show();
                                        },
                                      );
                                    });
                              } else {
                                _show();
                              }
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Color(0xffe5e5e5))),
                                  ),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    '采集人脸',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                )
                              ],
                            )),
                        GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              showElasticDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return BaseDialog(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: const Text("你确定要删除吗？",
                                            textAlign: TextAlign.center),
                                      ),
                                      onPressed: () async {
                                        NavigatorUtils.goBack(context);
                                        try {
                                          EasyLoading.show();
                                          String code =
                                          await PartyMemberRepository.deletePartyMember(
                                              widget.id);
                                          print(code);
                                          if (code == "204" || code == "200") {
                                            await Provider.of<DangjianViewModel>(context,
                                                listen: false)
                                                .getPartyMemberList();
                                            EasyLoading.dismiss();
                                            NavigatorUtils.goBack(this.context);
                                            ToastUtil.show('删除成功');
                                          }
//                                          NavigatorUtils.goBack(context);
                                          EasyLoading.dismiss();
                                        } catch (e, s) {
                                          EasyLoading.dismiss();
                                          getErrorTips(e, s, context: context);
                                          print(e);
                                        }
                                      },
                                    );
                                  });
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    '删除党员',
                                    style: TextStyle(color: Colors.red, fontSize: 16),
                                  ),
                                )
                              ],
                            )),
                        Container(
                          color: Color(0xFFf5f5f5),
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    '取消',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
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
                      margin: EdgeInsets.only(top: 10, bottom: 15,right: 5,left: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClickItem(
                            title: "姓名",
                            content: partyMember.name ?? '',
//                            onTap: () {},
                          ),
                          ClickItem(
                            title: "性别",
                            content: genderType
                                .enumName(partyMember.gender ?? 0),
//                            onTap: () {},
                          ),
                          ClickItem(
                            title: "身份证号",
                            content: partyMember.identityNumber ?? '',
//                            onTap: () {},
                          ),
                          ClickItem(
                            title: "手机号",
                            content: partyMember.mobileNumber ?? '',
                            onTap: () {
                              if(partyMember.mobileNumber != null)
                              Utils.launchTelURL(partyMember.mobileNumber);
                            },
                          ),
                          ClickItem(
                            title: "出生日期",
                            content: partyMember.birthDate != null
                                ? Utils.daysFormat(
                                DateTime.parse(partyMember.birthDate))
                                : "",
//                            onTap: () {},
                          ),
                          ClickItem(
                            title: "入党时间",
                            content: partyMember.joinDate != null
                                ? Utils.daysFormat(
                                DateTime.parse(partyMember.joinDate))
                                : "",
//                            onTap: () {},
                          ),
                          ClickItem(
                            title: "党员状态",
                            content: partyMemberType
                                .enumName(partyMember.partyMemberType ?? 0),
//                            onTap: () {},
                          ),
                          ClickItem(
                            title: "是否采集人脸",
                            content: partyMember.isUploadFace != null && partyMember.isUploadFace ? "是" : "否",
                            onTap: () {
                              if (partyMember.isUploadFace == true) {
                                showElasticDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return BaseDialog(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: const Text("你确定要再次已采集吗？",
                                              textAlign: TextAlign.center),
                                        ),
                                        onPressed: () async {
                                          _show();
                                        },
                                      );
                                    });
                              } else {
                                _show();
                              }
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
                      width: double.infinity,
                        margin: EdgeInsets.only(top: 10, bottom: 15,right: 5,left: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              partyMember.remarks ?? "无",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 17,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              )),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
            child: RanButton(
              text: '编辑信息',
//                isShape: true,
              onPressed: () async {
                NavigatorUtils.pushResult(context,
                    '${PartyMemberRouter.editPartyMemberPage}?id=${widget.id}',(res){
                      loadData();
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  _show() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,

      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 160,
          child: Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    var file =
                        await picker.getImage(source: ImageSource.gallery);
                    EasyLoading.show();
                    try {
                      String code = await PartyMemberRepository.postAddFace(
                          partyMember.id, file.path);
                      if (code == "200" || code == "204") {
                        loadData();
                        await Provider.of<DangjianViewModel>(this.context, listen: false)
                            .getPartyMemberList();
                        EasyLoading.dismiss();
                        ToastUtil.show('提交成功');
                      }
                      EasyLoading.dismiss();
                    } catch (e, s) {
                      print(e.toString());
                      EasyLoading.dismiss();
                      getErrorTips(e, s, context: this.context);
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xffe5e5e5))),
                        ),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          '从本地选择照片',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  )),
              GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    var file =
                    await picker.getImage(source: ImageSource.camera);
                    EasyLoading.show();
                    try {
                      String code = await PartyMemberRepository.postAddFace(partyMember.id,file.path);
                      if (code == "200" || code == "204") {
                        loadData();
                        await Provider.of<DangjianViewModel>(this.context, listen: false)
                            .getPartyMemberList();
                        EasyLoading.dismiss();
                        ToastUtil.show('提交成功');
                      }
                      EasyLoading.dismiss();
                    } catch (e, s) {
                      print(e.toString());
                      EasyLoading.dismiss();
                      getErrorTips(e, s, context: this.context);
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
//                          border: Border(
//                              bottom: BorderSide(
//                                  width: 1, color: Color(0xffe5e5e5))),
                        ),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          '拍照',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  )),
              Container(
                color: Color(0xFFf5f5f5),
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          '取消',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}
