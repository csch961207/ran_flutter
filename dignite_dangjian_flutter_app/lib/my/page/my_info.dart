import 'package:dignite_dangjian_flutter_app/organizationManagement/model/my_organization.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ran_flutter_account/account_repository.dart';
import 'package:ran_flutter_account/account_router.dart';
import 'package:ran_flutter_account/model/my_profile_model.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    MyOrganization myOrganization = Provider.of<DangjianViewModel>(context, listen: false).myOrganization;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '个人资料',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: APPColors.app_main,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color(0xFFF3F2F2),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ClickItem(
                              title: "姓名",
                              content: myOrganization?.name ?? '',
                            ),
                            ClickItem(
                              title: "党组织",
                              content: myOrganization?.organizationUnitName ?? '',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
//            Container(
//              color: Colors.white,
//              padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
//              child: RanButton(
//                text: '编辑资料',
////                isShape: true,
//                onPressed: () async {
//                  NavigatorUtils.pushResult(
//                      context,
//                      AccountRouter.editProfilePage,
//                          (result) => {getMyProfile()});
//                },
//              ),
//            ),
          ]),
    );
  }
}
