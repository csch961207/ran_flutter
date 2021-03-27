import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:litecaijing/config/router_manger.dart';
import 'package:litecaijing/model/postList_entity.dart';
import 'package:litecaijing/provider/provider_widget.dart';
import 'package:litecaijing/provider/view_state_widget.dart';
import 'package:litecaijing/res/resources.dart';
import 'package:litecaijing/ui/helper/refresh_helper.dart';
import 'package:litecaijing/ui/widget/article_skeleton.dart';
import 'package:litecaijing/ui/widget/posts_single_graph_item.dart';
import 'package:litecaijing/ui/widget/posts_three_diagram_item.dart';
import 'package:litecaijing/ui/widget/skeleton.dart';
import 'package:litecaijing/util/image_utils.dart';
import 'package:litecaijing/view_model/blog_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key key, this.id}) : super(key: key);

  final String id;
  @override
  BlogPageState createState() => BlogPageState();
}

class BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
            body: ProviderWidget<BlogModel>(
                model: BlogModel(widget.id),
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
                              image: ImageUtils.getImageProvider(model.blog?.background, holderImg: 'blog_bg'),
                              alignment: Alignment.topCenter,
                              fit: BoxFit.fitHeight,
                              colorFilter: ColorFilter.mode(
                                  Colors.indigoAccent[400].withOpacity(0.5),
                                  BlendMode.hardLight
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          child: Column(
                            children: <Widget>[
                              Text(
                                model.blog.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Dimens.font_sp18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                model.blog.description ?? '',
                                style: TextStyle(
                                    fontSize: Dimens.font_sp14,
                                    color: Colors.white
                                ),
                              ),
//                      Container(
//                        padding: EdgeInsets.all(10),
//                        child: GestureDetector(
//                          child: Container(
//                            alignment: Alignment.center,
//                            padding: EdgeInsets.symmetric(horizontal: 14.0),
//                            decoration: BoxDecoration(
//                                color: Colours.app_main,
//                                borderRadius: BorderRadius.circular(15.0)
//                            ),
//                            constraints: BoxConstraints(
//                                minWidth: 64.0,
//                                maxHeight: 30.0,
//                                minHeight: 30.0
//                            ),
//                            child: Text('+ 关注', style: TextStyle(fontSize: Dimens.font_sp12, color: Colors.white),),
//                          ),
//                          onTap: () {
//                          },
//                        ),
//                      ),
                            ],
                          ),)
                        ,
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
                              child: BlogArticleList(),
                            )
                        ],
                        )
                      ],
                    ),
                  );
                }))
    );
  }
}


class BlogArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlogModel blogModel = Provider.of(context);
    if (blogModel.isBusy) {
      return SkeletonList(
        builder: (context, index) => ArticleSkeletonItem(),
      );
    }
    return SmartRefresher(
        controller: blogModel.refreshController,
        header: WaterDropHeader(),
        footer: RefresherFooter(),
        onRefresh: blogModel.refresh,
        onLoading: blogModel.loadMore,
        enablePullUp: true,
        child: ListView.builder(
            itemCount: blogModel.list.length,
            itemBuilder: (context, index) {
              PostsItem item = blogModel.list[index];
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
  }
}