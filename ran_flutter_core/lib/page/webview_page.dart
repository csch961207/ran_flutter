import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_core/utils/bottomSheet_utils.dart';
import 'package:ran_flutter_core/utils/string_utils.dart';
import 'package:ran_flutter_core/utils/third_app_utils.dart';
import 'package:ran_flutter_core/widget/app_bar.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  final String title;
  final String url;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _webViewController;
  Completer<bool> _finishedCompleter = Completer();

  ValueNotifier canGoBack = ValueNotifier(false);
  ValueNotifier canGoForward = ValueNotifier(false);

  Future canOpenAppFuture;

  @override
  void initState() {
    canOpenAppFuture = ThirdAppUtils.canOpenApp(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          //移除html标签
          StringUtils.removeHtmlLabel(widget.title),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),
        ),
//        WebViewTitle(
//          title: widget.title,
//          future: _finishedCompleter.future,
//        ),
        centerTitle: true,
        actions: <Widget>[
          /// 刷新、在浏览器中打开、复制链接、分享
//          IconButton(
//            tooltip: '在浏览器中打开',
//            icon: Icon(Icons.language),
//            onPressed: () {
//              launch(widget.url, forceSafariVC: false);
//            },
//          ),
          IconButton(
            tooltip: '更多',
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              BottomSheetUtils.showBottomSheet(
                  context,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launch(widget.url, forceSafariVC: false);
                          NavigatorUtils.goBack(context);
                        },
                        child: Container(
                          width: 60,
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.language,
                                  size: 25,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '浏览器打开',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(widget.title + '  ' + widget.url);
                          NavigatorUtils.goBack(context);
                        },
                        child: Container(
                          width: 60,
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.share,
                                  size: 25,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '系统分享',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          try {
                            Clipboard.setData(ClipboardData(text: widget.url));
                            NavigatorUtils.goBack(context);
                            ToastUtil.show('复制成功');
                          } catch (e) {
                            ToastUtil.show(e.toString());
                          }
                        },
                        child: Container(
                          width: 60,
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.link,
                                  size: 25,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '复制链接',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _webViewController.reload();
                          NavigatorUtils.goBack(context);
                        },
                        child: Container(
                          width: 60,
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.autorenew,
                                  size: 25,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '刷新',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
//              launch(widget.url, forceSafariVC: false);
            },
          ),
//          WebViewPopupMenu(
//            _webViewController,
//            widget.title,
//            widget.url
//          )
        ],
//        bottom: PreferredSize(
//          child: _progressBar(lineProgress,context),
//          preferredSize: Size.fromHeight(3.0),
//        ),
      ),
      body: SafeArea(
        bottom: false,
        child: WebView(
          // 初始化加载的url
          initialUrl: widget.url,
          // 加载js
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            ///TODO isForMainFrame为false,页面不跳转.导致网页内很多链接点击没效果
            debugPrint('导航$request');
            if (!request.url.startsWith('http')) {
              ThirdAppUtils.openAppByUrl(request.url);
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
          onWebViewCreated: (WebViewController controller) {
            _webViewController = controller;
            _webViewController.currentUrl().then((url) {
              debugPrint('返回当前$url');
            });
          },
          onPageFinished: (String value) async {
            debugPrint('加载完成: $value');
            if (!_finishedCompleter.isCompleted) {
              _finishedCompleter.complete(true);
            }
            refreshNavigator();
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: IconTheme(
          data: Theme.of(context).iconTheme.copyWith(opacity: 0.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: canGoBack,
                builder: (context, value, child) => IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: !value
                        ? null
                        : () {
                            _webViewController.goBack();
                            refreshNavigator();
                          }),
              ),
              ValueListenableBuilder(
                valueListenable: canGoForward,
                builder: (context, value, child) => IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: !value
                        ? null
                        : () {
                            _webViewController.goForward();
                            refreshNavigator();
                          }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 刷新导航按钮
  ///
  /// 目前主要用来控制 '前进','后退'按钮是否可以点击
  /// 但是目前该方法没有合适的调用时机.
  /// 在[onPageFinished]中,会遗漏正在加载中的状态
  /// 在[navigationDelegate]中,会存在页面还没有加载就已经判断过了.
  void refreshNavigator() {
    /// 是否可以后退
    _webViewController.canGoBack().then((value) {
      debugPrint('canGoBack--->$value');
      return canGoBack.value = value;
    });

    /// 是否可以前进
    _webViewController.canGoForward().then((value) {
      debugPrint('canGoForward--->$value');
      return canGoForward.value = value;
    });
  }
}

class WebViewTitle extends StatelessWidget {
  final String title;
  final Future<bool> future;

  WebViewTitle({this.title, this.future});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FutureBuilder<bool>(
          future: future,
          initialData: false,
          builder: (context, snapshot) => snapshot.data
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(right: 5), child: AppBarIndicator()),
        ),
        Expanded(
            child: Text(
          //移除html标签
          StringUtils.removeHtmlLabel(title),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),
        ))
      ],
    );
  }
}

//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//import 'package:provider/provider.dart';
//import 'package:ran_flutter_core/config/resource_mananger.dart';
//import 'package:ran_flutter_core/config/routers/fluro_navigator.dart';
//import 'package:ran_flutter_core/utils/bottomSheet_utils.dart';
//import 'package:ran_flutter_core/utils/string_utils.dart';
//import 'package:share/share.dart';
//import 'package:url_launcher/url_launcher.dart';
//
//class WebViewPage extends StatefulWidget {
//  WebViewPage({
//    Key key,
//    @required this.title,
//    @required this.url,
//  }) : super(key: key);
//
//  final String title;
//  final String url;
//
//  @override
//  _WebViewPageState createState() => _WebViewPageState();
//}
//
//class _WebViewPageState extends State<WebViewPage> {
//  final flutterWebViewPlugin = FlutterWebviewPlugin();
//  Completer<bool> _finishedCompleter = Completer();
//  double lineProgress = 0.0;
//
//  @override
//  void initState() {
//    super.initState();
//    flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
//      debugPrint('onStateChanged: ${state.type} ${state.url}');
//      if (!_finishedCompleter.isCompleted &&
//          state.type == WebViewState.finishLoad) {
//        _finishedCompleter.complete(true);
//      }
//    });
//    flutterWebViewPlugin.onProgressChanged.listen((progress) {
//      print(progress);
//      setState(() {
//        lineProgress = progress;
//      });
//    });
//  }
//
//  @override
//  void dispose() {
//    flutterWebViewPlugin.dispose();
//    super.dispose();
//  }
//
//  _progressBar(double progress, BuildContext context) {
//    return new SizedBox(
//        height: 2.0,
//        child: new LinearProgressIndicator(
//          backgroundColor: Colors.white70.withOpacity(0),
//          value: progress == 1.0 ? 0 : progress,
//          valueColor:
//              new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
//        ));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return WebviewScaffold(
//      url: widget.url,
//      withJavascript: true,
//      displayZoomControls: false,
//      withZoom: true,
//      appBar: AppBar(
////        leading: InkWell(
////          onTap: (){
////            NavigatorUtils.goBack(context);
////          },
////          child: Image.asset(
////            'packages/ran_flutter_core/' + ImageHelper.wrapAssets('close.png'),
////            width: 5,
////            height: 5,
////            fit: BoxFit.fitWidth,
////            colorBlendMode: BlendMode.srcIn,
////          ),
////        ),
//        backgroundColor: Color(0xFFFFFFFF),
//        iconTheme: IconThemeData(color: Colors.black87),
//        title: Text(
//          //移除html标签
//          StringUtils.removeHtmlLabel(widget.title),
//          overflow: TextOverflow.ellipsis,
//          style: TextStyle(
//              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),
//        ),
////        WebViewTitle(
////          title: widget.title,
////          future: _finishedCompleter.future,
////        ),
//        centerTitle: true,
//        actions: <Widget>[
//          /// 刷新、在浏览器中打开、复制链接、系统分享
////          IconButton(
////            tooltip: '在浏览器中打开',
////            icon: Icon(Icons.language),
////            onPressed: () {
////              launch(widget.url, forceSafariVC: false);
////            },
////          ),
//          IconButton(
//            tooltip: '更多',
//            icon: Icon(Icons.more_horiz),
//            onPressed: () {
//              BottomSheetUtils.showBottomSheet(context,Text('内容'));
////              launch(widget.url, forceSafariVC: false);
//            },
//          ),
////          WebViewPopupMenu(
////            _webViewController,
////            widget.title,
////            widget.url
////          )
//        ],
//        bottom: PreferredSize(
//          child: _progressBar(lineProgress, context),
//          preferredSize: Size.fromHeight(1.0),
//        ),
//      ),
//      bottomNavigationBar: IconTheme(
//        data: Theme.of(context).iconTheme.copyWith(opacity: 0.5),
//        child: BottomAppBar(
//          child:
////          Container(
////            decoration: BoxDecoration(
////              borderRadius: BorderRadius.only(
////                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
////              color: Colors.white,
////            ),
////            child: Column(
////              children: [
////                Text('hhah')
////              ],
////            ),
////          )
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            children: <Widget>[
//              IconButton(
//                icon: const Icon(Icons.arrow_back_ios),
//                onPressed: flutterWebViewPlugin.goBack,
//              ),
//              IconButton(
//                icon: const Icon(Icons.arrow_forward_ios),
//                onPressed: flutterWebViewPlugin.goForward,
//              ),
//              IconButton(
//                icon: const Icon(Icons.autorenew),
//                onPressed: flutterWebViewPlugin.reload,
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
