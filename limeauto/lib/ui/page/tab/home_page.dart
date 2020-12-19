import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:limeauto/config/router_manger.dart';
import 'package:limeauto/flutter/search.dart';
import 'package:limeauto/model/entitiesList_entity.dart';
import 'package:limeauto/model/postList_entity.dart';
import 'package:limeauto/provider/provider_widget.dart';
import 'package:limeauto/provider/view_state_widget.dart';
import 'package:limeauto/ui/helper/refresh_helper.dart';
import 'package:limeauto/ui/page/search/search_delegate.dart';
import 'package:limeauto/ui/widget/animated_provider.dart';
import 'package:limeauto/ui/widget/article_skeleton.dart';
import 'package:limeauto/ui/widget/banner_image.dart';
import 'package:limeauto/ui/widget/load_image.dart';
import 'package:limeauto/ui/widget/posts_single_graph_item.dart';
import 'package:limeauto/ui/widget/posts_three_diagram_item.dart';
import 'package:limeauto/ui/widget/skeleton.dart';
import 'package:limeauto/utils/status_bar_utils.dart';
import 'package:limeauto/view_model/home_model.dart';
import 'package:limeauto/view_model/scroll_controller_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const double kHomeRefreshHeight = 40.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var bannerHeight = MediaQuery.of(context).size.width * 5 / 11;
    return ProviderWidget2<HomeModel, TapToTopModel>(
      model1: HomeModel(),
      // 使用PrimaryScrollController保留iOS点击状态栏回到顶部的功能
      model2: TapToTopModel(PrimaryScrollController.of(context),
          height: bannerHeight),
      onModelReady: (homeModel, tapToTopModel) {
        homeModel.initData();
        tapToTopModel.init();
      },
      builder: (context, homeModel, tapToTopModel, child) {
        if (homeModel.isBusy) {
          return ViewStateBusyWidget();
        } else if (homeModel.isError && homeModel.list.isEmpty) {
          return ViewStateErrorWidget(
              error: homeModel.viewStateError, onPressed: homeModel.initData);
        } else if (homeModel.isEmpty) {
          return ViewStateEmptyWidget(onPressed: homeModel.initData);
        }
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Scaffold(
              body: SmartRefresher(
                controller: homeModel.refreshController,
//              header: WaterDropHeader(),
                footer: RefresherFooter(),
                onRefresh: homeModel.refresh,
                onLoading: homeModel.loadMore,
                enablePullUp: true,
                child: ListView.builder(
                    controller: tapToTopModel.scrollController,
                    itemCount: homeModel.list.length,
                    itemBuilder: (context, index) {
                      PostsItem item = homeModel.list[index];
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            index == 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 25, 0, 10),
                                          child: Column(
                                            children: <Widget>[
                                              LoadAssetImage("img_logo",
                                                  width: 100.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 30, 0, 0),
                                        child: IconButton(
                                          color: Colors.orange,
                                          icon: Icon(Icons.search),
                                          onPressed: () {
                                            showSearch(
                                                context: context,
                                                delegate:
                                                    DefaultSearchDelegate());
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            index == 0
                                ? Container(
                                    height: bannerHeight,
                                    child: BannerWidget(),
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            index == 0
                                ? SizedBox(
                                    height: 10,
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
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
                    }),
              ),
              floatingActionButton: EmptyAnimatedSwitcher(
                display: tapToTopModel.showTopBtn,
                child: FloatingActionButton(
                  heroTag: 'homeEmpty',
                  key: ValueKey(Icons.vertical_align_top),
                  onPressed: () {
                    tapToTopModel.scrollToTop();
                  },
                  child: Icon(
                    Icons.vertical_align_top,
                  ),
                ),
              ),
            ));

//        return Scaffold(
//          body: SmartRefresher(
//              controller: homeModel.refreshController,
//              header: WaterDropHeader(),
//              footer: RefresherFooter(),
//              onRefresh: homeModel.refresh,
//              onLoading: homeModel.loadMore,
//              enablePullUp: true,
//              child: Column(
//                children: <Widget>[
////                        Container(
////                          height: double.infinity,
////                          child: HomeArticleList(),
////                        ),
//                ],
//              )),
//          floatingActionButton: EmptyAnimatedSwitcher(
//            display: tapToTopModel.showTopBtn,
//            child: FloatingActionButton(
//              heroTag: 'homeEmpty',
//              key: ValueKey(Icons.vertical_align_top),
//              onPressed: () {
//                tapToTopModel.scrollToTop();
//              },
//              child: Icon(
//                Icons.vertical_align_top,
//              ),
//            ),
//          ),
//        );
      },
    );
  }
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Consumer<HomeModel>(builder: (_, homeModel, __) {
        if (homeModel.isBusy) {
          return CupertinoActivityIndicator();
        } else {
//          var banners = homeModel?.banners ?? [];
          var banners = homeModel?.banners ?? [];
          return Swiper(
            loop: true,
            autoplay: true,
            pagination: SwiperPagination(
              //指示器显示的位置
              alignment:
                  Alignment.bottomRight, // 位置 Alignment.bottomCenter 底部中间
              // 距离调整
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
              // 指示器构建
              builder: FractionPaginationBuilder(
                  // 选中时字体大小
                  activeFontSize: 14,
                  // 字体大小
                  fontSize: 14,
                  // 字体颜色
                  color: Colors.white,
                  //选中时的颜色
                  activeColor: Colors.white),
            ),
            autoplayDelay: 5000,
            itemCount: banners.length,
            itemBuilder: (ctx, index) {
              FieldValues bannerImageFieldValue = banners[index]
                  .fieldValues
                  .firstWhere((fieldValue) =>
                      fieldValue.fieldId ==
                      '291b6cd5-c7a5-17fc-d6c3-39f94506da01');
              FieldValues postFieldValue = banners[index]
                  .fieldValues
                  .firstWhere((fieldValue) =>
                      fieldValue.fieldId ==
                      'd9411176-72ac-a508-8bd4-39f9441e94c2');
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteName.articleDetail,
                      arguments: jsonDecode(postFieldValue.maxTextValue)[0]);
                },
                child: Stack(
                  children: <Widget>[
//                      Image.network(
//                        jsonDecode(fieldValue.maxTextValue)[0]['webUrl'],
//                        height: 140 + 18 * 2.0,
//                        fit: BoxFit.fill,
//                      ),
                    Container(
                      height: double.infinity,
                      child: BannerImage(
//                      banners[index].imagePath)
                        jsonDecode(bannerImageFieldValue.maxTextValue)[0]
                            ['webUrl'],
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Opacity(
                          opacity: 0.4,
                          child: Container(
                            color: Colors.black,
                            width: double.infinity,
                            height: 50,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 100, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                banners[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}

class HomeArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    if (homeModel.isBusy) {
      return SkeletonList(
        builder: (context, index) => ArticleSkeletonItem(),
      );
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: homeModel.list.length,
        itemBuilder: (context, index) {
          PostsItem item = homeModel.list[index];
          return Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
//                index == 0
//                    ? BannerWidget()
//                    : SizedBox(
//                        height: 0,
//                      ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouteName.articleDetail, arguments: item.id);
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
  }
}
