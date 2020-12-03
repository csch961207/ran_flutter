import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/tab/home_page.dart';
import 'package:flutter_app/tab/message_page.dart';
import 'package:flutter_app/tab/my_page.dart';
import 'package:ran_flutter_site/ran_flutter_site.dart';
import 'package:provider/provider.dart';

List<Widget> pages = <Widget>[HomePage(), MessagePage(), SitePage(), MyPage()];

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
            if (index == 1) {
              Provider.of<SectionsViewModel>(context, listen: false)
                  .setAppointSections([
                'ziliaoku',
                'xiantuisong',
                'xiangzhenjiedaotuisong',
                'qita',
                'dongtai',
                'version'
              ]);
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text('税醒'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(
              Icons.message_outlined,
              color: Colors.blue,
            ),
            title: Text('助理'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            activeIcon: Icon(
              Icons.article,
              color: Colors.blue,
            ),
            title: Text('知识库'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(
              Icons.person,
              color: Colors.blue,
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
    super.initState();
  }
}
