import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:limeauto/config/router_manger.dart';
import 'package:limeauto/model/postList_entity.dart';
import 'package:limeauto/provider/provider_widget.dart';
import 'package:limeauto/provider/view_state_widget.dart';
import 'package:limeauto/ui/helper/refresh_helper.dart';
import 'package:limeauto/ui/widget/article_skeleton.dart';
import 'package:limeauto/ui/widget/posts_single_graph_item.dart';
import 'package:limeauto/ui/widget/posts_three_diagram_item.dart';
import 'package:limeauto/ui/widget/skeleton.dart';
import 'package:limeauto/view_model/structure_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 文章列表页面
class ArticleListPage extends StatefulWidget {
  /// 分类id
  final String cid;

  ArticleListPage(this.cid);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<PostListModel>(
      model: PostListModel(widget.cid),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return SkeletonList(
            builder: (context, index) => ArticleSkeletonItem(),
          );
        } else if (model.isError && model.list.isEmpty) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        } else if (model.isEmpty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        }
        return SmartRefresher(
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
                    child: Column(
                      children: <Widget>[
                        index == 0 ? SizedBox(height: 10,) : SizedBox(height: 0,),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(RouteName.articleDetail, arguments: item.id);
                          },
                          child: item.media.coverImages.length > 1 ? PostsThreeDiagramItem(postItem: item):
                          PostsSingleGraphItem(postItem: item),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,5.0,0,0),
                          child: Divider(),
                        ),
                      ],
                    ),
                  );
                }));
      },
    );
  }
}