import 'dart:convert';

import 'package:dayansoft/config/routers/fluro_navigator.dart';
import 'package:dayansoft/config/storage_manager.dart';
import 'package:dayansoft/event/event_router.dart';
import 'package:dayansoft/model/allEvents.dart';
import 'package:dayansoft/model/user.dart';
import 'package:dayansoft/res/resources.dart';
import 'package:dayansoft/service/app_repository.dart';
import 'package:dayansoft/utils/jhPickerTool.dart';
import 'package:dayansoft/widget/refresh_helper.dart';
import 'package:dayansoft/widget/view_state_widget.dart';
import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const double kHomeRefreshHeight = 180.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  bool get wantKeepAlive => true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  int page = 1;
  bool isLoading = false;

  String date = '';

  List<DATALIST> dataList = [];
  User user = new User();

  @override
  void initState() {
    super.initState();
    String data = StorageManager.sharedPreferences.getString("user");
    user = User.fromJson(json.decode(data));
    var newData = new DateTime.now();
    date = newData.year.toString() +
        '-' +
        (newData.month < 10
            ? '0' + newData.month.toString()
            : newData.month.toString());
    refresh();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      AllEvents allEvents = await AppRepository.findAllEvents(
          user.userId, user.dealerShipId, 1, 10, date);
      _refreshController.refreshCompleted();
      setState(() {
        dataList = allEvents.dATALIST;
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      refreshController.refreshFailed();
      setState(() {
        isLoading = false;
      });
    }
  }

  refresh() async {
    try {
      AllEvents allEvents = await AppRepository.findAllEvents(
          user.userId, user.dealerShipId, 1, 10, date);
      _refreshController.refreshCompleted();
      setState(() {
        dataList = allEvents.dATALIST;
//        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      refreshController.refreshFailed();
    }
  }

  loadMore() async {
    page++;
    try {
      AllEvents allEvents = await AppRepository.findAllEvents(
          user.userId, user.dealerShipId, page, 10, date);
      if (allEvents.dATALIST.isEmpty) {
        print('-------------------');
        print('空数据');
        print('-------------------');
        _refreshController.loadNoData();
      } else {
        dataList.addAll(allEvents.dATALIST);
        _refreshController.refreshCompleted();
      }
      setState(() {});
    } catch (e) {
      print(e.toString());
      refreshController.refreshFailed();
    }
  }

  selectMonthAndYear() {
    List<String> dates = date.split('-');
    int year = int.parse(dates[0]);
    int month = int.parse(dates[1]);
    JhPickerTool.showDatePicker(context,
        dateType: DateType.YM, title: "请选择年月", value: new DateTime(year, month),
        clickCallback: (var str, var time, var year, var month, var item) {
      print(str);
      print(time);
      print(year);
      print(month);
      print(item);
      setState(() {
        date = year.toString() +
            '-' +
            (month < 10 ? '0' + month.toString() : month.toString());
      });
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: Text(
              '活动展示',
              style: TextStyle(color: Colors.black),
            ),
//        centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black87),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: GestureDetector(
                    onTap: () {
                      selectMonthAndYear();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          date,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 18,
                        )
//                        Icon(
//                          CupertinoIcons.chevron_down,
//                          size: 16,
//                        )
                      ],
                    )),
              )
            ]),
        backgroundColor: Color.fromRGBO(244, 246, 250, 1),
        body: SafeArea(
            child: isLoading
                ? Center(
                    child: ViewStateBusyWidget(),
                  )
                : dataList.length != 0
                    ? SmartRefresher(
                        controller: _refreshController,
                        header: WaterDropHeader(),
                        footer: RefresherFooter(),
                        onRefresh: refresh,
                        onLoading: loadMore,
                        enablePullUp: true,
                        child: SingleChildScrollView(
                          child: AnimationLimiter(
                            child: Column(
                              children: AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 375),
                                childAnimationBuilder: (widget) =>
                                    SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: widget,
                                  ),
                                ),
                                children: childrenList(),
                              ),
                            ),
                          ),
                        ),
                      )
                    : ViewStateEmptyWidget(
                        image: Images.dataIsEmpty,
                        message: '',
                        onPressed: () {
                          getData();
                        },
                      )));
  }

  List<Widget> childrenList() {
    List<Widget> childs = [];
    for (var i = 0; i < dataList.length; i++) {
      DATALIST dataItem = dataList[i];
      childs.add(GestureDetector(
        onTap: () {
          NavigatorUtils.push(context,
              '${EventRouter.eventMaterialUploadPage}?id=${dataItem.id}');
        },
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(231, 231, 231, 1),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 4.0,
                  spreadRadius: 0.0),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 5,
                decoration: BoxDecoration(
                  color: Colours.app_main,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataItem.name,
                    style: TextStyle(
                        color: Color.fromRGBO(8, 16, 44, 1), fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    dataItem.eventformDescr,
                    style: TextStyle(
                        color: Color.fromRGBO(87, 92, 111, 1), fontSize: 13),
                  ),
                ],
              )
            ],
          ),
        ),
      ));
    }
    return childs;
  }
}
