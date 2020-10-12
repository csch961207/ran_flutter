import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:flutter/cupertino.dart';

const double kHomeRefreshHeight = 180.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text("首页"),
      ),
    );
  }
}
