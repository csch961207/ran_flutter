import 'package:flutter/material.dart';
import 'package:ran_flutter_fields/model/field_type_provider_model.dart';
import 'package:ran_flutter_fields/widget/assets/assets_widget.dart';
import 'package:ran_flutter_fields/widget/light_switch/light_switch_widget.dart';

class FieldTypes {
  static FieldTypeProviderModel assetsFieldTypeProvider =
      FieldTypeProviderModel(
          fieldTypeName: 'Assets', fieldTypeWidget: getAssetsBuild);

  static FieldTypeProviderModel lightSwitchFieldTypeProvider =
      FieldTypeProviderModel(
          fieldTypeName: 'LightSwitch', fieldTypeWidget: getLightSwitchBuild);

  static List<FieldTypeProviderModel> allFieldTypes = [
    assetsFieldTypeProvider,
    lightSwitchFieldTypeProvider
  ];
}
