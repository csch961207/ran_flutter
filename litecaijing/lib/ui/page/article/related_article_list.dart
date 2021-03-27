import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:litecaijing/config/router_manger.dart';
import 'package:litecaijing/model/postList_entity.dart';
import 'package:litecaijing/provider/provider_widget.dart';
import 'package:litecaijing/provider/view_state_widget.dart';
import 'package:litecaijing/ui/helper/refresh_helper.dart';
import 'package:litecaijing/ui/widget/article_skeleton.dart';
import 'package:litecaijing/ui/widget/posts_single_graph_item.dart';
import 'package:litecaijing/ui/widget/posts_three_diagram_item.dart';
import 'package:litecaijing/ui/widget/skeleton.dart';
import 'package:litecaijing/view_model/structure_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 文章列表页面
class RelatedArticleList extends StatefulWidget {
  /// 分类id
  final String cid;

  RelatedArticleList(this.cid);

  @override
  _RelatedArticleListState createState() => _RelatedArticleListState();
}

class _RelatedArticleListState extends State<RelatedArticleList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<RelatedArticleListModel>(
      model: RelatedArticleListModel(widget.cid),
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
        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
//                    index == 0 ? SizedBox(height: 10,) : SizedBox(height: 0,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.articleDetail, arguments: model.list[0].id);
                    },
                    child: model.list[0].media.coverImages.length > 1 ? PostsThreeDiagramItem(postItem: model.list[0]):
                    PostsSingleGraphItem(postItem: model.list[0]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,5.0,0,0),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
//                    index == 0 ? SizedBox(height: 10,) : SizedBox(height: 0,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.articleDetail, arguments: model.list[1].id);
                    },
                    child: model.list[1].media.coverImages.length > 1 ? PostsThreeDiagramItem(postItem: model.list[1]):
                    PostsSingleGraphItem(postItem: model.list[1]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,5.0,0,0),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
//                    index == 0 ? SizedBox(height: 10,) : SizedBox(height: 0,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.articleDetail, arguments: model.list[2].id);
                    },
                    child: model.list[2].media.coverImages.length > 1 ? PostsThreeDiagramItem(postItem: model.list[2]):
                    PostsSingleGraphItem(postItem: model.list[2]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,5.0,0,0),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
//                    index == 0 ? SizedBox(height: 10,) : SizedBox(height: 0,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.articleDetail, arguments: model.list[3].id);
                    },
                    child: model.list[3].media.coverImages.length > 1 ? PostsThreeDiagramItem(postItem: model.list[3]):
                    PostsSingleGraphItem(postItem: model.list[3]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,5.0,0,0),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
//                    index == 0 ? SizedBox(height: 10,) : SizedBox(height: 0,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.articleDetail, arguments: model.list[4].id);
                    },
                    child: model.list[4].media.coverImages.length > 1 ? PostsThreeDiagramItem(postItem: model.list[4]):
                    PostsSingleGraphItem(postItem: model.list[4]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,5.0,0,0),
                    child: Divider(),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
