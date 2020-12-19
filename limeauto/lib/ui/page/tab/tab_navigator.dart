import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limeauto/generated/l10n.dart';
import 'package:limeauto/ui/page/tab/find_page.dart';
import 'package:limeauto/ui/widget/app_update.dart';
import 'package:limeauto/utils/image_utils.dart';

import 'home_page.dart';
import 'project_page.dart';
import 'structure_page.dart';
import 'user_page.dart';
import 'wechat_account_page.dart';

List<Widget> pages = <Widget>[
  HomePage(),
  ProjectPage(),
  FindPage(),
  StructurePage(),
  UserPage()
];

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5.0,
        iconSize: 21.0,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('tabbar/shouye'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('tabbar/shouye_active'),
              width: 20.0,
              height: 20.0,
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Text('首页'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('tabbar/fenlei'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('tabbar/fenlei_active'),
              width: 20.0,
              height: 20.0,
            ),
            title: Text('分类'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('tabbar/faxian'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('tabbar/faxian_active'),
              width: 20.0,
              height: 20.0,
            ),
            title: Text('发现'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('tabbar/paihangbang'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('tabbar/paihangbang_active'),
              width: 20.0,
              height: 20.0,
            ),
            title: Text('排行'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('tabbar/wode'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('tabbar/wode_active'),
              width: 20.0,
              height: 20.0,
            ),
            title: Text('我的'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  @override
  void initState() {
//    checkAppUpdate(context);
    super.initState();
  }
}
