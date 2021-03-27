import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:litecaijing/config/router_manger.dart';
import 'package:litecaijing/model/navigation_site.dart';
import 'package:litecaijing/model/tree.dart';
import 'package:litecaijing/provider/provider_widget.dart';
import 'package:litecaijing/provider/view_state_widget.dart';
import 'package:litecaijing/res/styles.dart';
import 'package:litecaijing/ui/page/article/news_flashes_list_page.dart';
import 'package:litecaijing/ui/page/article/top_list_page.dart';
import 'package:litecaijing/util/theme_utils.dart';
import 'package:litecaijing/view_model/load_image.dart';
import 'package:litecaijing/view_model/structure_model.dart';
import 'package:sticky_headers/sticky_headers.dart';

///
class NewsFlashPage extends StatefulWidget {
  @override
  _NewsFlashPageState createState() => _NewsFlashPageState();
}

class _NewsFlashPageState extends State<NewsFlashPage>
    with AutomaticKeepAliveClientMixin {
  List<String> tabs = ['24小时热榜', '一周排行'];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
//          appBar: AppBar(
//              centerTitle: true,
//              title: TabBar(
//                isScrollable: true,
//                tabs: List.generate(
//                    tabs.length,
//                    (index) => Tab(
//                          text: tabs[index],
//                        )),
//              )),
        appBar: AppBar(
          backgroundColor: ThemeUtils.isDark(context)
              ? ThemeUtils.getStickyHeaderColor(context)
              : Colors.white,
          title: Text(
            '24小时热门快讯',
            style: TextStyle(
              fontSize: 19,
              color: ThemeUtils.isDark(context) ? Colors.white : Colors.black,
            ),
          ),
//            LoadAssetImage("img_logo",
//              width: 100.0,color: ThemeUtils.isDark(context)
//                  ? Colors.white
//                  : Colors.black,),
        ),
//          backgroundColor: Colors.white,
        body: NewsFlashListPage()
//          ListView.builder(
//            itemCount: 8,
//
//            /// 将item默认合并的语义拆开，自行组合， 另一种方式见 withdrawal_record_list_page.dart
//            addSemanticIndexes: false,
//            itemBuilder: (_, int index) {
//              return StickyHeader(
//                header: Container(
//                  alignment: Alignment.centerLeft,
//                  width: double.infinity,
//                  color: ThemeUtils.getBackgroundColor(context),
//                  padding: const EdgeInsets.only(left: 16.0),
//                  height: 34.0,
//                  child: Text('今天 03月24日 星期三',
//                      style: TextStyle(color: Colors.grey, fontSize: 12)),
//                ),
//                content: _buildItem(index),
//              );
//            },
//          ),
//          TabBarView(
//              children: [
//                TopListPage(1),
//                TopListPage(7)
////                StructureCategoryList(),
////                NavigationSiteCategoryList()
//              ])
    );
  }

  Widget _buildItem(int index) {
    final List<Container> list = List<Container>.generate(index + 1, (int i) {
      return Container(
        color: ThemeUtils.isDark(context)
            ? ThemeUtils.getStickyHeaderColor(context)
            : Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
//        decoration: BoxDecoration(
//          border: Border(
//            bottom: Divider.createBorderSide(context, width: 0.8),
//          ),
//        ),
        child: IndexedSemantics(
          index: index,
          child: Column(
            children: [Text('云南自贸试验区昆明片区加入世界自由区组织')],
          ),
        ),
      );
    });
    return Column(children: list);
  }
}
