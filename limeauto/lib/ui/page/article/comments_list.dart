import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:limeauto/model/articles_entity.dart';
import 'package:limeauto/model/comments_entity.dart';
import 'package:limeauto/provider/provider_widget.dart';
import 'package:limeauto/provider/view_state_widget.dart';
import 'package:limeauto/ui/helper/refresh_helper.dart';
import 'package:limeauto/ui/widget/article_skeleton.dart';
import 'package:limeauto/ui/widget/load_image.dart';

import 'package:limeauto/ui/widget/skeleton.dart';
import 'package:limeauto/utils/image_utils.dart';
import 'package:limeauto/view_model/article_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 评论列表
class CommentsListPage extends StatefulWidget {
  /// 文章id

  final ArticlesEntity articles;

  CommentsListPage(this.articles);

  @override
  _CommentsListPageState createState() => _CommentsListPageState();
}

class _CommentsListPageState extends State<CommentsListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return
//      ProviderWidget2(
//
//    );
      ProviderWidget2<CommentsListModel, AddCommentsModel>(
    model1: CommentsListModel(widget.articles.id),
    // 使用PrimaryScrollController保留iOS点击状态栏回到顶部的功能
    model2: AddCommentsModel(),
    onModelReady: (commentsListModel, addCommentsModel) {
      commentsListModel.initData();
    },
    builder: (context, commentsListModel, addCommentsModel, child) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.articles.commentCount.toString() + ' 条热评'),
                centerTitle: true),
            body: Stack(children: <Widget>[
              Container(
                height: double.infinity,
                child:  Consumer<CommentsListModel>
                  (builder: (_, commentsListModel, __) {
                    if (commentsListModel.isBusy) {
                      return SkeletonList(
                        builder: (context, index) => ArticleSkeletonItem(),
                      );
                    } else if (commentsListModel.isError && commentsListModel.list.isEmpty) {
                      return ViewStateErrorWidget(
                          error: commentsListModel.viewStateError, onPressed: commentsListModel.initData);
                    } else if (commentsListModel.isEmpty) {
                      return ViewStateEmptyWidget(onPressed: commentsListModel.initData);
                    }
                    return SmartRefresher(
                        controller: commentsListModel.refreshController,
                        header: WaterDropHeader(),
                        footer: RefresherFooter(),
                        onRefresh: commentsListModel.refresh,
                        onLoading: commentsListModel.loadMore,
                        enablePullUp: true,
                        child: ListView.builder(
                            itemCount: commentsListModel.list.length + 1,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (commentsListModel.list.length == index) {
                                return SizedBox(
                                  height: 72,
                                );
                              }
                              CommentsItem item = commentsListModel.list[index];
                              return Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                              radius: 20.0,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage:
                                                  ImageUtils.getImageProvider(
                                                      '',
                                                      holderImg: 'logo_icon')),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            item.writer.userName,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          item.text,
                                          style: TextStyle(
//                                    color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          '回复于 ' + item.creationTime,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: 1,
                                      )
                                    ],
                                  ));
                            }));
                  },
                ),
              ),
              Positioned(
                bottom: 48,
                left: 0,
                right: 0,
                child: Divider(height: 1, color: Color(0xFFEBEDF0)),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Color(0xFF303030),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    height: 64,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 38.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Color(0xFFfafafa)
                                    : Color(0xFF303030),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: TextField(
                                key: const Key('text_field'),
                                autofocus: true,
                                controller: _controller,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                      top: 6.0,
                                      left: 8.0,
                                      right: -16.0,
                                      bottom: 6.0),
                                  hintText: '发表评论',
                                  suffixIcon: InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, top: 8.0, bottom: 8.0),
                                      child: LoadAssetImage(
                                        "order/order_delete",
//                                  color: iconColor
                                      ),
                                    ),
                                    onTap: () {
                                      /// https://github.com/flutter/flutter/issues/35909
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                        _controller.text = "";
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),

                          FlatButton(
                            textColor: Theme.of(context).brightness ==
                                Brightness.light
                                ? Color(0xFFfafafa)
                                : Color(0xFF303030),
                            color: Theme.of(context).brightness ==
                                Brightness.light
                                ? Color(0xFF303030)
                                : Color(0xFFfafafa),
                            onPressed: () {
                              addCommentsModel.addComments(
                                  widget.articles.id, _controller.text).then((dynamic result){
                                commentsListModel.shuaxin();
                              });
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                _controller.text = "";
                              });
                              setState(() {
                                widget.articles.commentCount =
                                    widget.articles.commentCount + 1;
                              });
                            },
                            child: Text("发表",
                                style: TextStyle(fontSize: 14.0)),
                          )
//                          ProviderWidget<AddCommentsModel>(
//                              model: AddCommentsModel(),
//                              builder: (context, model, child) =>
//                          )
                        ]),
                  ))
            ])
        );});
  }
}
