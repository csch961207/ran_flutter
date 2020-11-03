import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 通用的footer
///
/// 由于国际化需要context的原因,所以无法在[RefreshConfiguration]配置
class RefresherFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      failedText: '加载失败',
      idleText: '上拉加载',
      loadingText: '加载中',
      noDataText: '没有更多数据了',
      canLoadingText: '松开加载更多'
    );
  }
}
