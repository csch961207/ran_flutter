import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limeauto/config/router_manger.dart';
import 'package:limeauto/provider/provider_widget.dart';
import 'package:limeauto/provider/view_state_widget.dart';
import 'package:limeauto/res/resources.dart';
import 'package:limeauto/ui/widget/load_image.dart';
import 'package:limeauto/util/image_utils.dart';
import 'package:limeauto/util/theme_utils.dart';
import 'package:limeauto/view_model/find_model.dart';

class FindPage extends StatefulWidget {
  @override
  FindPageState createState() => FindPageState();
}

class FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
//      backgroundColor: ThemeUtils.getStickyHeaderColor(context),
            body: ProviderWidget<FindModel>(
                model: FindModel(),
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
                  List<Widget> populartags = [];
                  List<Widget> blogs = [];
                  if (model.blogs != null) {
                    for (var item in model.blogs) {
                      blogs.add(new Container(
                          margin: EdgeInsets.all(10),
                          width: 130.0,
                          height: 90,
                          color: ThemeUtils.isDark(context)
                              ? ThemeUtils.getStickyHeaderColor(context)
                              : Colors.white,
                          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(RouteName.blog,
                                  arguments: item.id);
                            },
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Column(
                                children: <Widget>[
                                  Gaps.vGap8,
                                  CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          ImageUtils.getImageProvider('',
                                              holderImg: 'logo_icon')),
                                  Gaps.vGap8,
                                  Text(
                                    item.name != null ? item.name : '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Gaps.vGap5,
                                  Expanded(
                                      child: Text(
                                    item.description != null
                                        ? item.description
                                        : '这个人很懒什么都没写...',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colours.text_gray,
                                        fontSize: 12,
                                        decoration: TextDecoration.none),
                                    overflow: TextOverflow.ellipsis,
                                  ))
                                ],
                              ),
                            ),
                          )));
                    }
                  }
                  if (model.popularTags != null) {
                    for (var item in model.popularTags) {
                      populartags.add(
                        new Container(
                          width: 290,
                          height: 235,
                          margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(RouteName.popular,
                                  arguments: item.name);
                            },
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      CachedNetworkImage(
                                        width: 290,
                                        height: 110,
                                        fit: BoxFit.cover,
                                        imageUrl: item.icon,
                                      ),
                                      Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Opacity(
                                            opacity: 0.5,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 2, 5, 2),
                                              color: Colors.black,
                                              child: Text(
                                                item.name,
                                                style: TextStyle(
                                                    fontSize: 10.0,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5.0),
                                      bottomRight: Radius.circular(5.0)),
                                  child: Container(
                                    width: 290,
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                                    color: Colors.white,
                                    child: Text(
                                      item.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return SingleChildScrollView(
                    key: const Key('home'),
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flex(
                            direction: Axis.horizontal,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                                  child: Column(
                                    children: <Widget>[
                                      LoadAssetImage("img_logo", width: 100.0),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gaps.vGap16,
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                                  child: Text(
                                    '头条文章',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
//              HeadlinesPage(),
                          Gaps.vGap8,
                          Container(
                            child: Column(
                              children: <Widget>[
                                Flex(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 5, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          child: Container(
                                              height: 90,
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 20, 10, 20),
                                              color: ThemeUtils.isDark(context)
                                                  ? ThemeUtils
                                                      .getStickyHeaderColor(
                                                          context)
                                                  : Colors.white,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          RouteName
                                                              .articleDetail,
                                                          arguments:
                                                              model.list[0].media.id);
                                                },
                                                child: Text(
                                                  model.list[0].media.title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(5, 0, 10, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          child: Container(
                                              height: 90,
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 20, 10, 20),
                                              color: ThemeUtils.isDark(context)
                                                  ? ThemeUtils
                                                      .getStickyHeaderColor(
                                                          context)
                                                  : Colors.white,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          RouteName
                                                              .articleDetail,
                                                          arguments:
                                                              model.list[1].media.id);
                                                },
                                                child: Text(
                                                  model.list[1].media.title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 5, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          child: Container(
                                            height: 90,
                                            padding: EdgeInsets.fromLTRB(
                                                10, 20, 10, 20),
                                            color: ThemeUtils.isDark(context)
                                                ? ThemeUtils
                                                    .getStickyHeaderColor(
                                                        context)
                                                : Colors.white,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    RouteName.articleDetail,
                                                    arguments:
                                                        model.list[2].media.id);
                                              },
                                              child: Text(
                                                model.list[2].media.title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(5, 10, 10, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  RouteName.articleDetail,
                                                  arguments: model.list[3].media.id);
                                            },
                                            child: Container(
                                              height: 90,
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 20, 10, 20),
                                              color: ThemeUtils.isDark(context)
                                                  ? ThemeUtils
                                                      .getStickyHeaderColor(
                                                          context)
                                                  : Colors.white,
                                              child: Text(
                                                model.list[3].media.title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Gaps.vGap16,
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: Text(
                                    '推荐话题',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gaps.vGap5,
                          Container(
                            height: 161,
                            child: ListView(
                                //设置水平方向排列
                                scrollDirection: Axis.horizontal,
                                //添加子元素
                                children: populartags),
                          ),
                          Gaps.vGap8,
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: Text(
                                    '推荐作者',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 170,
                            child: ListView(
                              //设置水平方向排列
                              scrollDirection: Axis.horizontal,
                              //添加子元素
                              children: blogs,
                            ),
                          ),
                          Gaps.vGap8
                        ],
                      ),
                    ),
                  );
                })));
  }
}
