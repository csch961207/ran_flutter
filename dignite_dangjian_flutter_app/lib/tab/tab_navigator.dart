import 'package:dignite_dangjian_flutter_app/meeting/page/meeting_page.dart';
import 'package:dignite_dangjian_flutter_app/my/page/my_page.dart';
import 'package:dignite_dangjian_flutter_app/notice/page/notice_page.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/page/partyMember_page.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

List<Widget> pages = <Widget>[NoticePage(), MeetingPage(), PartyMemberPage(), MyPage()];

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
        selectedItemColor: APPColors.app_main,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('notice'),
              width: 24.0,
              height: 24.0,
              color: Colors.grey,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('notice-fill'),
              width: 24.0,
              height: 24.0,
            ),
            title: Text('通知'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('meeting'),
              width: 24.0,
              height: 24.0,
              color: Colors.grey,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('meeting-fill'),
              width: 24.0,
              height: 24.0,
            ),
            title: Text('会议'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('partyMember'),
              width: 24.0,
              height: 24.0,
              color: Colors.grey,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('partyMember-fill'),
              width: 24.0,
              height: 24.0,
            ),
            title: Text('党员'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: ImageUtils.getAssetImage('my'),
              width: 24.0,
              height: 24.0,
              color: Colors.grey,
            ),
            activeIcon: Image(
              image: ImageUtils.getAssetImage('my-fill'),
              width: 24.0,
              height: 24.0,
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
    get();
  }

  get() async{
    try {
      EasyLoading.show();
      await Provider.of<CoreViewModel>(context, listen: false).init();
      if(Provider.of<CoreViewModel>(context, listen: false).applicationConfiguration.currentUser.id != null){
          await Provider.of<DangjianViewModel>(context, listen: false).getMyOrganization();
          Provider.of<DangjianViewModel>(context, listen: false).getPartyMemberList();
          Provider.of<DangjianViewModel>(context, listen: false).getMeetingList();
      }
      EasyLoading.dismiss();
    } catch (e, s) {
      EasyLoading.dismiss();
      getErrorTips(e, s, context: context);
      print(e);
    }
  }
}
