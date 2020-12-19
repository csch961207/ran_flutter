import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:limeauto/config/router_manger.dart';
import 'package:limeauto/model/navigation_site.dart';
import 'package:limeauto/model/tree.dart';
import 'package:limeauto/provider/provider_widget.dart';
import 'package:limeauto/provider/view_state_widget.dart';
import 'package:limeauto/ui/page/article/top_list_page.dart';
import 'package:limeauto/view_model/structure_model.dart';


///
class StructurePage extends StatefulWidget {
  @override
  _StructurePageState createState() => _StructurePageState();
}

class _StructurePageState extends State<StructurePage>
    with AutomaticKeepAliveClientMixin {
  List<String> tabs = ['24小时热榜', '一周排行'];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: TabBar(
                isScrollable: true,
                tabs: List.generate(
                    tabs.length,
                    (index) => Tab(
                          text: tabs[index],
                        )),
              )),
          body: TabBarView(
              children: [
                TopListPage(1),
                TopListPage(7)
//                StructureCategoryList(),
//                NavigationSiteCategoryList()
              ])),
    );
  }
}
