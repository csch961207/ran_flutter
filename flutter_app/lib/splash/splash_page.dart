import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:junchengedmsflutterapp/config/routers/fluro_navigator.dart';
import 'package:junchengedmsflutterapp/config/routers/routers.dart';
import 'package:junchengedmsflutterapp/login/login_router.dart';


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
