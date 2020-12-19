import 'package:flutter/material.dart';
import 'package:ran_flutter_core/config/routers/fluro_navigator.dart';
import 'package:scan/scan.dart';
import 'package:image_picker/image_picker.dart';

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
        ScanView(
          controller: controller,
          scanAreaScale: .6,
          scanLineColor: color,
          onCapture: (data) {
            getResult(data);
          },
        ),
        Positioned(
          left: width/2-40,
          bottom: 50,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              stateSetter = setState;
              return MaterialButton(
                  child: Icon(
                    lightIcon,
                    size: 30,
                    color: Colors.white,
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
          top: 0,
          child: Container(
            width: width,
            color: Colors.transparent,
            padding: EdgeInsets.fromLTRB(10, 35, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    NavigatorUtils.goBack(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '扫一扫',
                  style: TextStyle(
                      fontSize: 18,
//                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                InkWell(
                  onTap: () async {
                    PickedFile pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      String result = await Scan.parse(pickedFile.path);
                      getResult(result);
                    }
                  },
                  child: Text(
                    '相册',
                    style: TextStyle(
                        fontSize: 17,
//                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
