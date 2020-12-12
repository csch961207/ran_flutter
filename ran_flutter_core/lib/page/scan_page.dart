import 'package:flutter/material.dart';
import 'package:ran_flutter_core/config/routers/fluro_navigator.dart';
import 'package:scan/scan.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  StateSetter stateSetter;
  IconData lightIcon = Icons.flash_off;
  ScanController controller = ScanController();

  void getResult(String result) {
    //TODO
    NavigatorUtils.goBackWithParams(context, result);
  }

  @override
  Widget build(BuildContext context) {
    var color = Color(0xFF4759DA);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        title: (Text(
//          "扫码",
//        )),
//      ),
      body: Stack(children: [
        Positioned(
          top: 0,
          child: Container(
            width: width,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.arrow_back), Text('扫码'), Text('相册')],
            ),
          ),
        ),
        ScanView(
          controller: controller,
          scanAreaScale: .7,
          scanLineColor: color,
          onCapture: (data) {
            getResult(data);
          },
        ),
        Positioned(
          left: 10,
          bottom: 90,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              stateSetter = setState;
              return MaterialButton(
                  child: Icon(
                    lightIcon,
                    size: 40,
                    color: color,
                  ),
                  onPressed: () {
                    controller.toggleTorchMode();
                    if (lightIcon == Icons.flash_on) {
                      lightIcon = Icons.flash_off;
                    } else {
                      lightIcon = Icons.flash_on;
                    }
                    stateSetter(() {});
                  });
            },
          ),
        ),
        Positioned(
          right: 10,
          bottom: 90,
          child: MaterialButton(
              child: Icon(
                Icons.image,
                size: 40,
                color: color,
              ),
              onPressed: () async {
//                    List<Media> res = await ImagesPicker.pick();
//                    if (res != null) {
//                      String result = await Scan.parse(res[0].path);
//                      getResult(result);
//                    }
              }),
        ),
      ]),
    );
  }
}
