import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:litecaijing/config/router_manger.dart';
import 'package:litecaijing/model/postList_entity.dart';
import 'package:litecaijing/provider/provider_widget.dart';
import 'package:litecaijing/provider/view_state_widget.dart';
import 'package:litecaijing/ui/helper/refresh_helper.dart';
import 'package:litecaijing/ui/page/article/flow_event_row_page.dart';
import 'package:litecaijing/ui/widget/article_skeleton.dart';
import 'package:litecaijing/ui/widget/posts_single_graph_item.dart';
import 'package:litecaijing/ui/widget/posts_three_diagram_item.dart';
import 'package:litecaijing/ui/widget/skeleton.dart';
import 'package:litecaijing/view_model/project_model.dart';
import 'package:litecaijing/view_model/structure_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 文章列表页面
class NewsFlashListPage extends StatefulWidget {
  @override
  _NewsFlashListPageState createState() => _NewsFlashListPageState();
}

class _NewsFlashListPageState extends State<NewsFlashListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<NewsFlashModel>(
      model: NewsFlashModel(),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return ViewStateBusyWidget();
        } else if (model.isError && model.list.isEmpty) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        } else if (model.isEmpty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        }
        return Stack(
          fit: StackFit.loose,
          children: <Widget>[
            // 左边的竖线
            Positioned(
              left: 21,
              top: 15,
              bottom: 15,
              child: VerticalDivider(
                width: 1,
              ),
            ),
            // 右边的事件列表
            SmartRefresher(
                controller: model.refreshController,
                header: WaterDropHeader(),
                footer: RefresherFooter(),
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                enablePullUp: true,
                child: ListView.builder(
                    itemCount: model.list.length,
                    itemBuilder: (context, index) {
                      PostsItem item = model.list[index];
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        alignment: Alignment.centerLeft,
                        child: FlowEventRow(
                          title: item.media.webPage.title,
                          description: item.media.webPage.description,
                          publishTime: item.publishTime,
                          url: item.media.webPage.url,
                        ),
                      );
                    }))
          ],
        );
      },
    );
  }
}
