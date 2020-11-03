import 'package:flutter/cupertino.dart';
import 'package:ran_flutter_fields/model/field_model.dart';
import 'package:ran_flutter_fields/widget/assets/assets.dart';

class AssetsWidget extends StatefulWidget {
  final Field field;
  AssetsWidget({Key key, this.field}) : super(key: key);

  @override
  AssetsWidgetState createState() => AssetsWidgetState();
}

class AssetsWidgetState extends State<AssetsWidget> {
  Assets assets = new Assets();

  @override
  void initState() {
    super.initState();
    assets = Assets.fromJson(widget.field.configuration);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(assets.assetsSources[0]),
    );
  }
}

Widget getAssetsBuild(Field field) {
  return AssetsWidget(
    field: field,
  );
}
