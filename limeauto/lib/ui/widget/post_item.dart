import 'package:flutter/material.dart';
import 'package:limeauto/generated/l10n.dart';
import 'package:limeauto/model/adminPostList_entity.dart';
import 'package:limeauto/ui/widget/load_image.dart';
import 'package:limeauto/ui/widget/menu_reveal.dart';
import 'package:limeauto/utils/date_utils_.dart';

class PostItem extends StatelessWidget {
  const PostItem(
      {Key key,
      @required this.adminPostItem,
      @required this.index,
      @required this.selectIndex,
      @required this.onTapMenu,
      @required this.onTapEdit,
      @required this.onTapOperation,
      @required this.onTapDelete,
      @required this.onTapMenuClose,
      @required this.animation})
      : super(key: key);

  final AdminPostItem adminPostItem;
  final int index;
  final int selectIndex;
  final Function onTapMenu;
  final Function onTapEdit;
  final Function onTapOperation;
  final Function onTapDelete;
  final Function onTapMenuClose;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border(
              bottom: Divider.createBorderSide(context, width: 0.8),
            )),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(adminPostItem.media.title,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            auditedStatus(adminPostItem.auditedStatus),
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                            key: Key('goods_menu_item_$index'),
                            width: 24.0,
                            height: 24.0,
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: const LoadAssetImage("ellipsis")),
                        onTap: onTapMenu,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          Utils.apiDayFormat(
                              DateTime.parse(adminPostItem.publishTime)),
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Offstage(
            offstage: selectIndex != index,
            child: AnimatedBuilder(
                animation: animation,
                builder: (_, child) {
                  return MenuReveal(
                    revealPercent: animation.value,
                    child: InkWell(
                      onTap: onTapMenuClose,
                      child: Container(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color(0xB34D4D4D)
                            : const Color(0x4D000000),
                        child: Theme(
                          // 修改button默认的最小宽度与padding
                          data: Theme.of(context).copyWith(
                            buttonTheme: ButtonThemeData(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              minWidth: 56.0,
                              height: 56.0,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap, // 距顶部距离为0
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                            textTheme: TextTheme(
                                button: TextStyle(
                              fontSize: 16,
                            )),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(width: 15.0),
                              FlatButton(
                                key: Key('post_edit_item_$index'),
                                textColor: Colors.black54,
                                color: Colors.white,
                                child: const Text("查看"),
                                onPressed: onTapEdit,
                              ),
//                              FlatButton(
//                                key: Key('post_operation_item_$index'),
//                                color: Colors.white,
//                                child: const Text("下架"),
//                                onPressed: onTapOperation,
//                              ),
//                              FlatButton(
//                                key: Key('post_delete_item_$index'),
//                                color: Colors.white,
//                                textColor: Colors.redAccent,
//                                child: const Text("删除"),
//                                onPressed: onTapDelete,
//                              ),
                              SizedBox(width: 15.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  String auditedStatus(String status) {
    if(status == 'Allowed') {
      return "通过审核";
    }
    if(status == 'Disallowed') {
      return "已驳回";
    }
    return "等待审核";
  }
}
