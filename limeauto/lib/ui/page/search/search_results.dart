import 'package:flutter/material.dart';
import 'package:limeauto/model/postList_entity.dart';
import 'package:limeauto/provider/provider_widget.dart';
import 'package:limeauto/provider/view_state_widget.dart';
import 'package:limeauto/ui/helper/refresh_helper.dart';
import 'package:limeauto/ui/widget/article_list_Item.dart';
import 'package:limeauto/ui/widget/posts_single_graph_item.dart';
import 'package:limeauto/view_model/search_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class SearchResults extends StatelessWidget {
  final String keyword;
  final SearchHistoryModel searchHistoryModel;

  SearchResults({this.keyword, this.searchHistoryModel});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SearchResultModel>(
      model: SearchResultModel(
          keyword: keyword, searchHistoryModel: searchHistoryModel),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        if (model.isBusy) {
          return ViewStateBusyWidget();
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
                        InkWell(
                          onTap: () {
//                            NavigatorUtils.push(context, '${PostsRouter.postsArticlesPage}?id=${provider.list[index].id}');
                          },
                          child: PostsSingleGraphItem(postItem: item),
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
