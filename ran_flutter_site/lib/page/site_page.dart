import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ran_flutter_core/utils/utilsources.dart';
import 'package:ran_flutter_site/model/section_model.dart';
import 'package:ran_flutter_site/page/entity_list_page.dart';
import 'package:ran_flutter_site/view_model/section_view_model.dart';

class SitePage extends StatefulWidget {
  @override
  _SitePageState createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  ValueNotifier<int> valueNotifier;
  TabController tabController;
  @override
  void initState() {
    valueNotifier = ValueNotifier(0);
    super.initState();
//    Provider.of<SectionsViewModel>(context, listen: false)
//        .setAppointSections(['ziliaoku']);
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    List<Section> appointSections =
        Provider.of<SectionsViewModel>(context, listen: false).appointSections;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: StatusBarUtils.systemUiOverlayStyle(context),
        child: ValueListenableProvider<int>.value(
            value: valueNotifier,
            child: DefaultTabController(
                length: appointSections.length,
                child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: color, //把appbar的背景色改成透明
                      // elevation: 0,//appbar的阴影
                      title: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  print('搜索');
                                },
                                child: Container(
//                            margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/icon_home_search.png",
                                        width: 15,
                                        height: 15,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "   搜索文章",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: SafeArea(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                  width: double.infinity,
                                  height: 45,
                                  color: Colors.white,
                                  padding: EdgeInsets.only(bottom: 0, top: 0),
                                  margin: const EdgeInsets.only(top: 0),
                                  child: TabBar(
                                    isScrollable: true,
                                    labelColor: color,
                                    unselectedLabelColor: Colors.black54,
                                    labelStyle: TextStyle(fontSize: 16),
                                    indicatorColor: color,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorWeight: 2,
                                    indicatorPadding:
                                        EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    tabs: List.generate(
                                        appointSections.length,
                                        (index) => Text(appointSections[index]
                                            .displayName)),
                                  ))
                            ],
                          ),
                          Divider(height: 1, color: Colors.grey),
                          Expanded(
                            child: TabBarView(
                                children: List.generate(
                                    appointSections.length,
                                    (index) => EntityListPage(
                                        appointSections[index].id))),
                          )
                        ],
                      ),
                    )))));
  }
}
