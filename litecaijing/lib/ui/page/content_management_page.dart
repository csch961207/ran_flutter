import 'package:flutter/material.dart'
    hide SliverAnimatedListState, SliverAnimatedList;
import 'package:litecaijing/config/router_manger.dart';
import 'package:litecaijing/flutter/refresh_animatedlist.dart';
import 'package:litecaijing/provider/provider_widget.dart';
import 'package:litecaijing/provider/view_state_widget.dart';
import 'package:litecaijing/ui/helper/refresh_helper.dart';
import 'package:litecaijing/ui/widget/article_skeleton.dart';
import 'package:litecaijing/ui/widget/post_delete_bottom_sheet.dart';
import 'package:litecaijing/ui/widget/post_item.dart';
import 'package:litecaijing/ui/widget/skeleton.dart';
import 'package:litecaijing/view_model/project_model.dart';
import 'package:litecaijing/view_model/structure_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class ContentManagementPage extends StatefulWidget {
  @override
  _ContentManagementPageState createState() => _ContentManagementPageState();
}

class _ContentManagementPageState extends State<ContentManagementPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin  {
  final GlobalKey<SliverAnimatedListState> listKey =
      GlobalKey<SliverAnimatedListState>();

  int _selectIndex = -1;
  Animation<double> _animation;
  AnimationController _controller;
  List _list = [];

  @override
  void initState() {
    super.initState();
    // 初始化动画控制
    _controller = new AnimationController(duration: const Duration(milliseconds: 450), vsync: this);
    // 动画曲线
    CurvedAnimation _curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);
    _animation = new Tween(begin: 0.0, end: 1.1).animate(_curvedAnimation);

    //Item数量

  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  List<String> _imgList = [
    "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3130502839,1206722360&fm=26&gp=0.jpg",
    "https://xxx", // 故意使用一张错误链接
    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1762976310,1236462418&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3659255919,3211745976&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2085939314,235211629&fm=26&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2441563887,1184810091&fm=26&gp=0.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('内容管理'),
      ),
      body: ProviderWidget<AdminPostListModel>(
        model: AdminPostListModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isBusy) {
            return SkeletonList(
              builder: (context, index) => ArticleSkeletonItem(),
            );
          } else if (model.isError) {
            return ViewStateUnAuthWidget(onPressed: () async {
              Navigator.of(context).pushNamed(RouteName.login);
            });
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
                    return PostItem(
                      index: index,
                      selectIndex: _selectIndex,
                      adminPostItem: model.list[index],
                      animation: _animation,
                      onTapMenu: (){
                        // 开始执行动画
                        _controller.forward(from: 0.0);
                        setState(() {
                          _selectIndex = index;
                        });
                      },
                      onTapMenuClose: (){
                        _controller.reverse(from: 1.1);
                        _selectIndex = -1;
                      },
                      onTapEdit: (){
                        setState(() {
                          _selectIndex = -1;
                        });
                        Navigator.of(context).pushNamed(RouteName.articleDetail, arguments: model.list[index].id);
                      },
                      onTapOperation: (){
                      },
                      onTapDelete: (){
                        _controller.reverse(from: 1.1);
                        _selectIndex = -1;
                        _showDeleteBottomSheet(index);
                      },
                    );
                  }),
          );
        },
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;

  _showDeleteBottomSheet(int index){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PostDeleteBottomSheet(
          onTapDelete: (){
          },
        );
      },
    );
  }

}
