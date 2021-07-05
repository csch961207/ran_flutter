import 'package:dignite_dangjian_flutter_app/account/widget/organizationUnit_bottom_sheet.dart';
import 'package:dignite_dangjian_flutter_app/organizationManagement/model/register_model.dart';
import 'package:dignite_dangjian_flutter_app/organizationManagement/organizationManagement_repository.dart';
import 'package:dignite_dangjian_flutter_app/organizationUnit/model/organizationUnit_list_model.dart';
import 'package:dignite_dangjian_flutter_app/organizationUnit/model/organizationUnit_model.dart';
import 'package:dignite_dangjian_flutter_app/organizationUnit/organizationUnit_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';

import 'package:provider/provider.dart';
import 'package:ran_flutter_account/account_repository.dart';
import 'package:ran_flutter_account/model/login_res_model.dart';
import 'package:ran_flutter_account/model/register_res_model.dart';
import 'package:ran_flutter_account/widgets/login_field_widget.dart';

import 'package:ran_flutter_account/widgets/third_component.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// outside new  inside dispose may be crash. watch it
  /// 理论上应该在当前页面dispose,
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pwdFocus = FocusNode();
  bool isBusy = false;
  bool isAgree = true;

  List<OrganizationUnit> organizationUnitTabs = [OrganizationUnit(displayName: '请选择')];
  List<List<OrganizationUnit>> organizationUnitList = [];
  int organizationUnitTabIndex = 0;

  String organizationUnitName = "";

  Edit edit = new Edit();

  @override
  void initState() {
    super.initState();
    getData();
  }
  getData() async {
    try {
      EasyLoading.show();
      OrganizationUnitList organizationUnits =
      await OrganizationUnitRepository.getOrganizationUnitListByChildren(null,false);
      setState(() {
        organizationUnitList.add(organizationUnits.items);
      });
      EasyLoading.dismiss();
    } catch (e, s) {
      EasyLoading.dismiss();
      print(e.toString());
      getErrorTips(e, s, context: context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _pwdFocus.unfocus();
    _pwdFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '账号注册',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Color(0xFFF3F2F2),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Color(0xFFF3F2F2),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
//                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                    borderRadius:
                    BorderRadius.all(Radius.circular(8)),
                    child: Image.asset(
                      ImageHelper.wrapAssets('account-logo.png'),
                      width: 60,
                      height: 60,
                      fit: BoxFit.fitWidth,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${Environment.oAuthConfig['appName']}',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                child: LoginTextField(
                  label: '用户名',
                  icon: Icons.perm_identity,
                  controller: _userNameController,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) {
//                    FocusScope.of(context).requestFocus(_pwdFocus);
                  },
                ),
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                child: LoginTextField(
                  controller: _passwordController,
                  label: '密码',
                  icon: Icons.lock_outline,
                  obscureText: true,
//                  focusNode: _pwdFocus,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                child: LoginTextField(
                  label: '姓名',
                  icon: Icons.assignment_ind_outlined,
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) {
//                    FocusScope.of(context).requestFocus(_pwdFocus);
                  },
                ),
              ),
              Container(
                  height: 55.0,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                  ),
                  child: ClickItem(
                    widgetIcon: Icon(
                      Icons.account_balance_rounded,
                      color: Theme.of(context).accentColor,
                      size: 17,
                    ),
                    title: '选择组织',
                    titleTextStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    content: organizationUnitName ?? "",
                    onTap: () {
                      if(organizationUnitList.isEmpty){
                        ToastUtil.show('无党组织可选');
                        return;
                      }
                    showModalBottomSheet<void>(
                      context: context,

                      /// 使用true则高度不受16分之9的最高限制
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context1, state2) {
                          return OrganizationUnitBottomSheet<OrganizationUnit>(
                            title: '选择党组织',
                            labelProperty: 'displayName',
                            myTabs: organizationUnitTabs,
                            mList: organizationUnitList,
                            currentIndex: organizationUnitTabIndex,
                            onSelected: (organizationUnit) {
                              print(organizationUnit.toString());
                              setState(() {
                                this.edit.organizationUnitId =
                                    organizationUnit.id;
                                this.organizationUnitName  = organizationUnit.displayName;
                              });
//                              initData();
                            },
                            onTabPressed: (tabIndex) {
                              print(tabIndex);
                              state2(() {
                                organizationUnitTabIndex = tabIndex;
                              });
                            },
                            onListPressed: (tabIndex, listIndex) async {
                              try {
                                OrganizationUnitList organizationUnits =
                                await OrganizationUnitRepository.getOrganizationUnitListByChildren(organizationUnitList[tabIndex]
                                    [listIndex]
                                        .id,false);
                                if (organizationUnits.items.isEmpty) {
                                  setState(() {
                                    this.edit.organizationUnitId =
                                        organizationUnitList[tabIndex][listIndex].id;
                                    this.organizationUnitName = organizationUnitList[tabIndex][listIndex].displayName;
                                  });
                                print(organizationUnitList[tabIndex][listIndex].id);
                                print(organizationUnitList[tabIndex][listIndex].displayName);
                                  NavigatorUtils.goBack(context);
                                  return;
                                }
                                state2(() {
                                  organizationUnitTabs.removeRange(
                                      tabIndex, organizationUnitTabs.length);
                                  organizationUnitTabs
                                      .add(organizationUnitList[tabIndex][listIndex]);
                                  organizationUnitTabs.add(OrganizationUnit(displayName: '请选择'));
                                  organizationUnitList.insert(
                                      tabIndex + 1, organizationUnits.items);
                                  organizationUnitTabIndex++;
                                });
                              } catch (e) {}
                            },
                          );
                        });
                      },
                    );
                    },
                  )),
              SizedBox(
                height: 15,
              ),
//              Padding(
//                padding: EdgeInsets.only(left: 20, right: 20),
//                child: Row(
//                  children: [
//                    SizedBox(
//                      width: 5,
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        setState(() {
//                          isAgree = !isAgree;
//                        });
//                      },
//                      child: Image.asset(
//                        'packages/ran_flutter_account/' +
//                                ImageHelper.wrapAssets('check.png'),
//                        width: 15,
//                        height: 15,
//                        fit: BoxFit.fitWidth,
////                        colorBlendMode: BlendMode.srcIn,
//                        color: isAgree ? color : color.withOpacity(0.4),
//                      ),
//                    ),
//                    SizedBox(
//                      width: 5,
//                    ),
//                    Text(
//                      '我已阅读并同意',
//                      style: TextStyle(color: Colors.grey, fontSize: 12),
//                    ),
//                    InkWell(
//                      onTap: () {
//                        NavigatorUtils.goWebViewPage(context,
//                            'https://www.apple.com.cn/legal/internet-services/terms/site.html');
//                      },
//                      child: Text(
//                        '《用户许可协议》 ',
//                        style: TextStyle(color: color, fontSize: 12),
//                      ),
//                    ),
//                    InkWell(
//                      onTap: () {
//                        NavigatorUtils.goWebViewPage(
//                            context, 'https://m.mafengwo.cn/privacy.php');
//                      },
//                      child: Text(
//                        ' 《隐私政策》',
//                        style: TextStyle(color: color, fontSize: 12),
//                      ),
//                    )
//                  ],
//                ),
//              ),
              SizedBox(
                height: 10,
              ),
              LoginButtonWidget(
                child: isBusy
                    ? ButtonProgressIndicator()
                    : Text(
                        '注册',
                        style: Theme.of(context)
                            .accentTextTheme
                            .title
                            .copyWith(wordSpacing: 6),
                      ),
                onPressed: isBusy
                    ? null
                    : () async {
                        String name = _nameController.text;
                        String password = _passwordController.text;
                        String userName = _userNameController.text;
                        if(userName.isEmpty){
                          ToastUtil.show('请输入用户名');
                        }
                        if (password.isEmpty) {
                          ToastUtil.show('请输入密码');
                          return;
                        }
                        if (name.isEmpty) {
                          ToastUtil.show('请输入姓名');
                          return;
                        }
                        if(this.edit.organizationUnitId.isEmpty){
                          ToastUtil.show('请选择党组织');
                          return;
                        }
//                        if (!isAgree) {
//                          ToastUtil.show('请先同意用户协议');
//                          return;
//                        }
                        setState(() {
                          isBusy = true;
                        });
                        try {
//                          RegisterRes registerRes =
//                              await AccountRepository.register(
//                                  _nameController.text,
//                                  _passwordController.text,
//                                  _emailAddressController.text);
//                          if (registerRes.id != null) {
//                            ToastUtil.show('注册成功');
//                            NavigatorUtils.goBackWithParams(
//                                context, registerRes.userName);
//                          }
                        this.edit.name = name;
                          String code = await OrganizationManagementRepository
                              .postRegister(Register(
                                  userName: userName,
                                  password: password,
                                  edit: this.edit));
                          if (code == "204") {
                            ToastUtil.show('注册成功');
                            NavigatorUtils.goBackWithParams(
                                context, _nameController.text);
                          }
//                        NavigatorUtils.push(context, 'home',
//                            clearStack: true, transition: TransitionType.inFromBottom);
                          setState(() {
                            isBusy = false;
                          });
                        } catch (e, s) {
                          print(e.toString());
                          getErrorTips(e, s, context: context);
                          setState(() {
                            isBusy = false;
                          });
                        }
                      },
              ),
            ]),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    bool isBusy = false;
    return LoginButtonWidget(
      child: isBusy
          ? ButtonProgressIndicator()
          : Text(
              '注册',
              style: Theme.of(context)
                  .accentTextTheme
                  .title
                  .copyWith(wordSpacing: 6),
            ),
      onPressed: isBusy
          ? null
          : () {
              var formState = Form.of(context);
              if (formState.validate()) {}
            },
    );
  }
}

/// LoginPage 按钮样式封装
class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(5),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}
