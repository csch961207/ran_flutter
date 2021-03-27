import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:litecaijing/config/router_manger.dart';
import 'package:litecaijing/provider/provider_widget.dart';
import 'package:litecaijing/provider/view_state_widget.dart';
import 'package:litecaijing/ui/page/article/related_article_list.dart';
import 'package:litecaijing/ui/widget/article_skeleton.dart';
import 'package:litecaijing/ui/widget/like_count.dart';
import 'package:litecaijing/ui/widget/skeleton.dart';
import 'package:litecaijing/utils/date_utils_.dart';
import 'package:litecaijing/utils/image_utils.dart';
import 'package:litecaijing/utils/platform_utils.dart';
import 'package:litecaijing/view_model/article_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:share/share.dart';
//import 'package:sharesdk_plugin/sharesdk_plugin.dart';

/// 文章详情
class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key key, this.id}) : super(key: key);

  final String id;

  @override
  ArticlesPageState createState() => ArticlesPageState();
}

class ArticlesPageState extends State<ArticlesPage>
    with AutomaticKeepAliveClientMixin {
  bool _isDividerGone = true;
  ScrollController _controller = new ScrollController();

  int likeCount;
  bool isClientInstalled = false;
  bool isIOS = false;

  initShareSDK() {
//    ShareSDKRegister register = ShareSDKRegister();
//
//    register.setupWechat("wx3d0e31cbdd6ba900",
//        "99597dc6bcd4d939bf0d965b86eded60", "https://eigyo.share2dlink.com/");
//
//    SharesdkPlugin.regist(register);
  }

  @override
  void initState() {
    print('已修改过');
    super.initState();
    initShareSDK();
//    debugPrint();
//    if (Platform.isIOS) {
//      //ios相关代码
//      setState(() {
//        isIOS = true;
//      });
//      print('ios');
//      SharesdkPlugin.isClientInstalled(ShareSDKPlatforms.wechatSession)
//          .then((dynamic hasClient) {
//        if (hasClient == true) {
//          setState(() {
//            this.isClientInstalled = true;
//          });
//        }
//      });
//    } else if (Platform.isAndroid) {
//      //android相关代码
//      this.isClientInstalled = true;
//      SharesdkPlugin.isClientInstalled(ShareSDKPlatforms.wechatSession)
//          .then((dynamic hasClient) {
//        showAlertText('是否安装微信',hasClient,context);
//        print("返回状态" + hasClient.toString());
//        if (hasClient['state'] == 'uninstalled') {
//          setState(() {
//            this.isClientInstalled = false;
//          });
//        }
//      });
//    }
    _controller.addListener(() {
      print(_controller.offset);
      //170
      if (_controller.offset <= 100) {
        setState(() {
          if (_controller.offset > 100) {
            _isDividerGone = false;
          } else {
            _isDividerGone = true;
          }
        });
      } else {
        setState(() {
          _isDividerGone = false;
        });
      }
    });
  }

  void showAlertText(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
                title: new Text(title),
                content: new Text(content != null ? content : ""),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]));
  }

//  void showAlert(SSDKResponseState state, Map content, BuildContext context) {
//    String title = "失败";
//    switch (state) {
//      case SSDKResponseState.Success:
//        title = "成功";
//        break;
//      case SSDKResponseState.Fail:
//        title = "失败";
//        break;
//      case SSDKResponseState.Cancel:
//        title = "取消";
//        break;
//      default:
//        title = state.toString();
//        break;
//    }
//    showDialog(
//        context: context,
//        builder: (BuildContext context) => CupertinoAlertDialog(
//                title: new Text(title),
//                content: new Text(content != null ? content.toString() : ""),
//                actions: <Widget>[
//                  new FlatButton(
//                    child: new Text("OK"),
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                  )
//                ]));
//  }
//
//  userWeChatShare(BuildContext context, ArticleModel article) {
//    SSDKMap params = SSDKMap()
//      ..setGeneral(
//          article.article.media.title,
//          null,
//          article.article.media.coverImages[0],
//          article.article.media.coverImages[0],
//          null,
//          "http://litecaijing.com.cn/" + article.article.url,
//          article.article.media.coverImages[0],
//          null,
//          null,
//          null,
//          SSDKContentTypes.webpage);
//    SharesdkPlugin.showMenu(null, params, (SSDKResponseState state,
//        ShareSDKPlatform platform,
//        Map userData,
//        Map contentEntity,
//        SSDKError error) {
//      showAlert(state, error.rawData, context);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: ProviderWidget<ArticleModel>(
      model: ArticleModel(widget.id),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return ViewStateBusyWidget();
        } else if (model.isError) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        } else if (model.isEmpty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        }
        ArticleModel article = model;
        return SafeArea(
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              SingleChildScrollView(
                controller: _controller,
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 48,
//                        color: Color(0xFFF6F7F8),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Text(
                          article.article.media.title,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(RouteName.blog,
                                  arguments: article.article.blog.id);
                            },
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        ImageUtils.getImageProvider('',
                                            holderImg: 'logo_icon')),
                                SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      article.article.blog.name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                        Utils.apiDayFormat(DateTime.parse(
                                            article.article.publishTime)),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.grey))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Html(
                      data: article.article.media?.content ?? '',
                      padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
                      defaultTextStyle: TextStyle(fontSize: 16),
                      linkStyle: const TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                            child: Text(
                              '相关推荐',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RelatedArticleList(article.article.categoryId),
                    Container(
                      height: 48,
//                        color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).brightness == Brightness.light
                    ? Color(0xFFfafafa)
                    : Color(0xFF303030),
                constraints: BoxConstraints.expand(height: 48),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
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
                                width: 16,
                                height: 18,
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                      left: 30,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(RouteName.blog,
                                arguments: article.article.blog.id);
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Offstage(
                                offstage: _isDividerGone,
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                        radius: 16.0,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            ImageUtils.getImageProvider('',
                                                holderImg: 'logo_icon')),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Text(
                                        article.article.blog.name,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Offstage(
                        offstage: _isDividerGone,
                        child: Divider(height: 1, color: Color(0xFFEBEDF0)),
                      ),
                    ),
                  ],
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
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RouteName.commentsList,
                                arguments: article.article);
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '评论',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 20,
                            child: VerticalDivider(color: Colors.grey)),
                        LikeCount(id: widget.id),
                        Container(
                            height: 20,
                            child: VerticalDivider(color: Colors.grey)),
                        GestureDetector(
                          onTap: () {
                            return
//                              isClientInstalled ?
//                            userWeChatShare(context, article) :
                            Share.share('【' + article.article.media.title + '】'"http://litecaijing.com.cn/" + article.article.url,);
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.launch, color: Colors.grey),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '转发',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        );
      },
    )));
  }

//  Widget titleView() {
//    return
//  }

//  Widget contentView() {
//    return
//  }

  @override
  bool get wantKeepAlive => true;
}
