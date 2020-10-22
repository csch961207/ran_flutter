import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/tab/assets_widget.dart';
import 'package:flutter_app/tab/field.dart';
import 'package:flutter_app/tab/field_type_provider.dart';
import 'package:flutter_app/tab/field_type_provider_model.dart';
import 'package:flutter_app/tab/light_switch_widget.dart';

const double kHomeRefreshHeight = 180.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Field field = new Field();

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
    field = Field.fromJson({
      "fieldTypeName": "LightSwitch",
      "configuration": {
        "defaultValue": false,
        "required": false,
        "description": null,
        "assemblyNameAndTypeName":
            "Ran.Fields.Domain.Shared.dll;Ran.Fields.FieldTypes.LightswitchField.LightswitchFieldConfiguration"
      },
    });
    print(field.configuration['assetsSources']);
    FieldTypeProviderModel assetsFieldTypeProvider = FieldTypeProviderModel(
        fieldTypeName: 'Assets', fieldTypeWidget: getAssetsBuild);
    FieldTypeProviderModel lightSwitchFieldTypeProvider =
        FieldTypeProviderModel(
            fieldTypeName: 'LightSwitch', fieldTypeWidget: getLightSwitchBuild);
    FieldTypeProvider.addFieldTypeProviderModel([
      assetsFieldTypeProvider,
      lightSwitchFieldTypeProvider
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(child: FieldTypeProvider.getFieldTypeProviderWidget(field)),
    );
  }
}
