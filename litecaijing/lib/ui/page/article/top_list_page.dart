import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:litecaijing/common/common.dart';
import 'package:litecaijing/config/router_manger.dart';
import 'package:litecaijing/model/postList_entity.dart';
import 'package:litecaijing/provider/provider_widget.dart';
import 'package:litecaijing/provider/view_state_widget.dart';
import 'package:litecaijing/res/resources.dart';
import 'package:litecaijing/ui/widget/article_skeleton.dart';
import 'package:litecaijing/ui/widget/load_image.dart';
import 'package:litecaijing/ui/widget/posts_single_graph_item.dart';
import 'package:litecaijing/ui/widget/posts_three_diagram_item.dart';
import 'package:litecaijing/ui/widget/skeleton.dart';
import 'package:litecaijing/view_model/project_model.dart';

/// 热门页
class TopListPage extends StatefulWidget {
  /// 天数
  final int inDays;

  TopListPage(this.inDays);

  @override
  _TopListPageState createState() => _TopListPageState();
}

class _TopListPageState extends State<TopListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TopListModel>(
      model: TopListModel(widget.inDays),
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

        List<Widget> list = [];
        for (var index = 0; index < model.list.length; index++) {
          PostsItem item = model.list[index];
          list.add(new Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                index == 0
                    ? SizedBox(
                        height: 10,
                      )
                    : SizedBox(
                        height: 0,
                      ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouteName.articleDetail, arguments: item.id);
                  },
                  child: Row(
                    children: <Widget>[
                      index <= 2
                          ? LoadAssetImage(
                              "statistic/${index == 0 ? "champion" : index == 1 ? "runnerup" : "thirdplace"}",
                              width: 40.0,
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: 18.0,
                              height: 18.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 11.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Constant.colorList[index]),
                              child: Text("${index + 1}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                      Gaps.hGap4,
                      Expanded(child: PostsSingleGraphItem(postItem: item)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                  child: Divider(),
                ),
              ],
            ),
          ));
        }
        return Column(
          children: list,
        );
      },
    );
  }
}
