import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OrganizationUnitBottomSheet<T> extends StatefulWidget {
  const OrganizationUnitBottomSheet({
    Key key,
    @required this.myTabs,
    @required this.mList,
    this.title,
    this.onSelected,
    this.onListPressed,
    this.onTabPressed,
    this.labelProperty = 'name',
    this.currentIndex = 0,
  }) : super(key: key);

  final Function(dynamic) onSelected;
  final List<T> myTabs;
  final List<List<T>> mList;
  final String labelProperty;
  final Function(int tabIndex, int listIndex) onListPressed;
  final Function(int tabIndex) onTabPressed;
  final String title;
  final int currentIndex;

  @override
  OrganizationUnitBottomSheetState createState() => OrganizationUnitBottomSheetState();
}

class OrganizationUnitBottomSheetState extends State<OrganizationUnitBottomSheet>
    with SingleTickerProviderStateMixin {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));
    WidgetsBinding.instance.addPostFrameCallback((_) {
//      widget.provider.initData();
//      _tabController.animateTo(widget.provider.index,
//          duration: const Duration(microseconds: 0));
    });
  }

  /*
    底部导航点击事件
 */
  _onTabChanged() {
    print('走了');
    if (this.mounted) {
      print('走了里面');
    }
//    if (controller.indexIsChanging) {
//    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var color = Theme.of(context).accentColor;
    return Material(
      color: Colors.white,
      child: SizedBox(
        height: height * 8.0 / 16.0,
        /// 为保留状态，选择ChangeNotifierProvider.value，销毁自己手动处理（见 goods_edit_page.dart ：dispose()）
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    widget.title ?? '',
                    style: TextStyles.textBold16,
                  ),
                ),
                Positioned(
                  child: InkWell(
                    onTap: () {
                      widget.onSelected(widget.myTabs[widget.currentIndex]);
                      NavigatorUtils.goBack(context);
                    },
                    child: SizedBox(
//                      height: 16.0,
//                      width: 16.0,
                      child: Text('确认',style: TextStyle(color: color),),
                    ),
                  ),
                  right: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                )
              ],
            ),
            Gaps.line,
            Container(
              height: 50.0,
              // 隐藏点击效果
              color: Colors.white,
              child: ListView(
                controller: _controller,
                //设置水平方向排列
                scrollDirection: Axis.horizontal,
                //添加子元素
                children: List.generate(
                    widget.myTabs.length,
                    (index) => InkWell(
                          onTap: () {
                            print('打印');
                            widget.onTabPressed(index);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 7, 5, 0),
                            margin: EdgeInsets.fromLTRB(5, 7, 5, 0),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      // 设置单侧边框的样式
                                      color: widget.currentIndex == index
                                          ? color
                                          : Colors.white,
                                      width: 2,
                                      style: BorderStyle.solid)),
                            ),
                            child: Text(widget.myTabs[index]
                                .toJson()[widget.labelProperty]),
                          ),
                        )),
              ),
            ),
            Gaps.line,
            Expanded(
              child: ListView.builder(
                itemExtent: 48.0,
                itemBuilder: (_, index) {
                  final bool flag = widget.mList[widget.currentIndex][index]
                          .toJson()[widget.labelProperty] ==
                      widget.myTabs[widget.currentIndex]
                          .toJson()[widget.labelProperty];
                  return InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Text(
                              widget.mList[widget.currentIndex][index]
                                  .toJson()[widget.labelProperty],
                              style: flag
                                  ? TextStyle(
                                      fontSize: Dimens.font_sp14,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : null),
                        ],
                      ),
                    ),
                    onTap: () async {
                      print('打印');
                      EasyLoading.show();
                      try {
                        await widget.onListPressed(widget.currentIndex, index);
                        EasyLoading.dismiss();
                        Timer(Duration(milliseconds: 100),
                                () => _controller.jumpTo(_controller.position.maxScrollExtent));
                      } catch (e) {
                        print(e);
                        EasyLoading.dismiss();
                      }
                    },
                  );
                },
                itemCount: widget.mList[widget.currentIndex].length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
