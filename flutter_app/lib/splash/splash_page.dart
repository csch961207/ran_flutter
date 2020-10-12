import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/routers/routers.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';


///@author longshaohua
/// 引导页
class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startHome();
  }

  startHome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
//      Navigator.pushReplacement(
//        context,
//        MaterialPageRoute(builder: (context) => MyHomePage()),
//      );
      NavigatorUtils.push(context, Routes.home,
          clearStack: true, transition: TransitionType.inFromBottom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/launch_image.png",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
