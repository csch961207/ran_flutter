import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:litecaijing/ui/page/tab/find_page.dart';
import 'package:litecaijing/ui/page/tab/news_flash_page.dart';
import 'package:litecaijing/utils/image_utils.dart';

import 'classification_page.dart';
import 'home_page.dart';
import 'user_page.dart';


List<Widget> pages = <Widget>[
  HomePage(),
  ClassificationPage(),
  FindPage(),
  NewsFlashPage(),
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
              image: ImageUtils.getAssetImage('tabbar/home'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('tabbar/home_selected'),
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
              image: ImageUtils.getAssetImage('tabbar/more'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('tabbar/more_selected'),
              width: 20.0,
              height: 20.0,
            ),
            title: Text('分类'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('tabbar/explore'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('tabbar/explore_selected'),
              width: 20.0,
              height: 20.0,
            ),
            title: Text('发现'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('tabbar/signal'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('tabbar/signal_selected'),
              width: 20.0,
              height: 20.0,
            ),
            title: Text('快讯'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('tabbar/user'),
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('tabbar/user_selected'),
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
