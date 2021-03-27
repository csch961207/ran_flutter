

import 'package:flutter/material.dart';
import 'package:litecaijing/ui/widget/post_delete_bottom_sheet.dart';
import 'package:litecaijing/ui/widget/post_item.dart';


class PostList extends StatefulWidget {

  const PostList({
    Key key,
    @required this.index
  }): super(key: key);

  final int index;

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {

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
    _maxPage = widget.index == 0 ? 1 : (widget.index == 1 ? 2 : 3);

    _onRefresh();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _page = 1;
        _list = List.generate(widget.index == 0 ? 3 : 10, (i) => 'newItem：$i');
      });
    });
  }

  Future _loadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'newItem：$i'));
        _page ++;
      });
    });
  }

  int _page = 1;
  int _maxPage;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return PostItem(
            index: index,
            selectIndex: _selectIndex,
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
//              NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=false');
            },
            onTapOperation: (){

            },
            onTapDelete: (){
              _controller.reverse(from: 1.1);
              _selectIndex = -1;
              _showDeleteBottomSheet(index);
            },
          );
        });
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