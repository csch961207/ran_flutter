import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:flutter/cupertino.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
//import 'package:ran_flutter_fields/ran_flutter_fields.dart';
import 'package:provider/provider.dart';
//import 'package:ran_flutter_message/ran_flutter_message.dart';
//import 'package:ran_flutter_site/ran_flutter_site.dart';

const double kHomeRefreshHeight = 180.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

//  Field field = new Field();

//  Enterprises enterprises;
//
//  getEnterprises() async {
//    try {
//      Enterprises res = await EnterprisesRepository.fetchEnterprises(1);
//      setState(() {
//        enterprises = res;
//      });
//    } catch (e, s) {
//      print(e.toString());
//      getErrorTips(e, s, context: context);
//    }
//  }

  @override
  void initState() {
    super.initState();
//    field = Field.fromJson({
//      "fieldTypeName": "Assets",
//      "configuration": {
//        "assetsSources": ["f7b3c83d-ce93-b97a-d461-39f74767cfff"],
//        "minimum": null,
//        "maximum": 1,
//        "required": false,
//        "description": null,
//        "assemblyNameAndTypeName":
//            "Ran.Assets.Field.dll;Ran.Assets.AssetsField.AssetsFieldConfiguration"
//      },
//    });
//    field = Field.fromJson({
//      "fieldTypeName": "LightSwitch",
//      "configuration": {
//        "defaultValue": false,
//        "required": false,
//        "description": null,
//        "assemblyNameAndTypeName":
//            "Ran.Fields.Domain.Shared.dll;Ran.Fields.FieldTypes.LightswitchField.LightswitchFieldConfiguration"
//      },
//    });
//    print(field.configuration['assetsSources']);
    insert();
//    get();
    queryNum();
    query();
  }

  static queryNum() async {
//    PersonDbProvider provider = new PersonDbProvider();
//    int count = await provider.queryNum();
//    print('获取该表的数量');
//    print(count);
  }

  static query() async {
//    PersonDbProvider provider = new PersonDbProvider();
//    await provider.query(1, 0);
  }

  static get() async {
//    PersonDbProvider provider = new PersonDbProvider();
//    UserModel user = await provider.getPersonInfo("1143824942687547399");
    print('数据库获取事件执行');
//    print(user.uuid);
  }

  static insert() async {
//    PersonDbProvider provider = new PersonDbProvider();
//    UserModel userModel = UserModel();
//    userModel.uuid = "1143824942687547399";
//    userModel.mobile = "15801071159";
//    userModel.headImage = "http://www.img";
//    provider.insert(userModel);
  }

  static update() async {
//    PersonDbProvider provider = new PersonDbProvider();
//    UserModel userModel = await provider.getPersonInfo("1143824942687547394");
//    userModel.mobile = "15801071157";
//    userModel.headImage = "http://www.img1";
//    provider.update(userModel);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Column(
      children: [
//        FieldTypeProvider.getFieldTypeProviderWidget(field),
        Container(
          child: Consumer< CoreViewModel>(
              builder: (context, coreViewModel, child) {
            if (coreViewModel.applicationConfiguration.localization != null) {
              print(coreViewModel.applicationConfiguration.localization
                  .currentCulture.displayName);
            }
            return Container(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: (){
                  NavigatorUtils.goWebViewPage(context,
                            'https://www.apple.com.cn/legal/internet-services/terms/site.html');
                },
                child: Text('百度'),
              ),
            );
          }),
        )
      ],
    ));
  }
}
