import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limeauto/config/router_manger.dart';
import 'package:limeauto/model/postList_entity.dart';
import 'package:limeauto/provider/provider_widget.dart';
import 'package:limeauto/provider/view_state_widget.dart';
import 'package:limeauto/res/resources.dart';
import 'package:limeauto/ui/helper/refresh_helper.dart';
import 'package:limeauto/ui/widget/article_skeleton.dart';
import 'package:limeauto/ui/widget/posts_single_graph_item.dart';
import 'package:limeauto/ui/widget/posts_three_diagram_item.dart';
import 'package:limeauto/ui/widget/skeleton.dart';
import 'package:limeauto/util/image_utils.dart';
import 'package:limeauto/view_model/popularTag_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({Key key, this.name}) : super(key: key);

  final String name;
  @override
  PopularPageState createState() => PopularPageState();
}

class PopularPageState extends State<PopularPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
            body: ProviderWidget<PopularTagModel>(
                model: PopularTagModel(widget.name),
                onModelReady: (model) {
                  model.initData();
                },
                builder: (context, model, child) {
                  if (model.isBusy) {
                    return ViewStateBusyWidget();
                  }
                  if (model.isError) {
                    return ViewStateErrorWidget(
                        error: model.viewStateError, onPressed: model.initData);
                  }
                  if (model.isEmpty) {
                    return ViewStateErrorWidget(
                        error: model.viewStateError, onPressed: model.initData);
                  }
                  return SafeArea(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          height: 150,
                          padding: EdgeInsets.fromLTRB(15, 68, 15, 20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ImageUtils.getImageProvider(
                                  model.popularTag?.icon,
                                  holderImg: 'blog_bg'),
                              alignment: Alignment.topCenter,
                              fit: BoxFit.fitHeight,
                              colorFilter: ColorFilter.mode(
                                  Colors.indigoAccent[400].withOpacity(0.5),
                                  BlendMode.hardLight),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          child: Column(
                            children: <Widget>[
                              Text(
                                model.popularTag.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Dimens.font_sp18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Container(
                                width: 250,
                                child: Text(
                                  model.popularTag.description ?? '',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimens.font_sp14,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 13,
                            left: 0,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Image.asset(
                                    'assets/images/icon_back.png',
                                    color: Colors.white,
                                    width: 16,
                                    height: 18,
                                  ),
                                ),
                              ),
                            )),
                        Column(
                          children: <Widget>[
                            Container(
                              height: 150,
//                            color: Color(0xFFF6F7F8),
                            ),
                            Flexible(
                              child: PopularArticleList(),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                })));
  }
}

class PopularArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PopularTagModel popularTagModel = Provider.of(context);
    if (popularTagModel.isBusy) {
      return SkeletonList(
        builder: (context, index) => ArticleSkeletonItem(),
      );
    }
    return SmartRefresher(
        controller: popularTagModel.refreshController,
        header: WaterDropHeader(),
        footer: RefresherFooter(),
        onRefresh: popularTagModel.refresh,
        onLoading: popularTagModel.loadMore,
        enablePullUp: true,
        child: ListView.builder(
            itemCount: popularTagModel.list.length,
            itemBuilder: (context, index) {
              PostsItem item = popularTagModel.list[index];
              return Container(
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
                        Navigator.of(context).pushNamed(RouteName.articleDetail,
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
            }));
  }
}
