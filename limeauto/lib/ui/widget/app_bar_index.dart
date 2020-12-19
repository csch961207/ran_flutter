
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limeauto/res/resources.dart';
import 'package:limeauto/ui/page/search/search_delegate.dart';
import 'package:limeauto/ui/widget/load_image.dart';


/// 首页AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget{


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      children: <Widget>[
                        LoadAssetImage("img_logo", width: 100.0),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
//                      showSearch(
//                          context: context,
//                          delegate: DefaultSearchDelegate());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
