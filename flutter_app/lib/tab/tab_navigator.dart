import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junchengedmsflutterapp/enterprises/page/enterprises_page.dart';
import 'package:junchengedmsflutterapp/generated/l10n.dart';
import 'package:junchengedmsflutterapp/home/home_page.dart';
import 'package:junchengedmsflutterapp/my/page/my_page.dart';
import 'package:junchengedmsflutterapp/ui/page/tab/user_page.dart';
import 'package:junchengedmsflutterapp/utils/image_utils.dart';
import 'package:junchengedmsflutterapp/work/page/work_page.dart';

List<Widget> pages = <Widget>[EnterprisesPage(), WorkPage(), MyPage()];

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
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('home'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('home-filling'),
              width: 20.0,
              height: 20.0,
            ),
            title: Text('企业'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('work'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('work-filling'),
              width: 20.0,
              height: 20.0,
            ),
            title: Text('信访'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('user'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('user-filling'),
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
