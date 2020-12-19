import 'package:flutter/material.dart'
    hide SliverAnimatedListState, SliverAnimatedList;
import 'package:limeauto/common/common.dart';
import 'package:limeauto/config/router_manger.dart';
import 'package:limeauto/flutter/refresh_animatedlist.dart';
import 'package:limeauto/model/postList_entity.dart';
import 'package:limeauto/provider/provider_widget.dart';
import 'package:limeauto/provider/view_state_widget.dart';
import 'package:limeauto/res/gaps.dart';
import 'package:limeauto/ui/helper/refresh_helper.dart';
import 'package:limeauto/ui/widget/article_skeleton.dart';
import 'package:limeauto/ui/widget/load_image.dart';
import 'package:limeauto/ui/widget/posts_single_graph_item.dart';
import 'package:limeauto/ui/widget/posts_three_diagram_item.dart';
import 'package:limeauto/ui/widget/skeleton.dart';

import 'package:limeauto/view_model/readingRecord_model.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReadingRecordListPage extends StatefulWidget {
  @override
  _ReadingRecordListPageState createState() => _ReadingRecordListPageState();
}

class _ReadingRecordListPageState extends State<ReadingRecordListPage> {
  final GlobalKey<SliverAnimatedListState> listKey =
      GlobalKey<SliverAnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('浏览记录'),
        centerTitle: true,
      ),
      body: ProviderWidget<ReadingRecordListModel>(
        model: ReadingRecordListModel(),
        onModelReady: (model) async {
          await model.initData();
        },
        builder: (context, ReadingRecordListModel model, child) {
          if (model.isBusy) {
            return SkeletonList(
              builder: (context, index) => ArticleSkeletonItem(),
            );
          } else if (model.isEmpty) {
            return ViewStateEmptyWidget(onPressed: model.initData);
          } else if (model.isError) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          }
          return ListView.builder(
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
                          Navigator.of(context).pushNamed(
                              RouteName.articleDetail,
                              arguments: item.id);
                        },
                        child: item.media.coverImages.length > 1
                            ? PostsThreeDiagramItem(postItem: item)
                            : PostsSingleGraphItem(postItem: item),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                        child: Divider(),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
