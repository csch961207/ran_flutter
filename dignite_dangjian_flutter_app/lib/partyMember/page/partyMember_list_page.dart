import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMember_item_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_list_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/widget_utils.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../partyMember_repository.dart';

class MyStatelessWidget extends StatelessWidget {
  final String text;
  MyStatelessWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}

class PartyMemberListPage extends StatelessWidget {
  final List<PartyMemberItem> partyMemberItem;
  PartyMemberListPage({Key key, this.partyMemberItem}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AzListView(
            data: partyMemberItem,
            itemCount: partyMemberItem.length,
            itemBuilder: (BuildContext context, int index) {
              PartyMemberItem model = partyMemberItem[index];
              return WidgetUtils.getWeChatListItem(
                context,
                model,
                defHeaderBgColor: Color(0xFFE5E5E5),
              );
            },
            physics: BouncingScrollPhysics(),
            susItemBuilder: (BuildContext context, int index) {
              PartyMemberItem model = partyMemberItem[index];
              if ('↑' == model.getSuspensionTag()) {
                return Container();
              }
              return WidgetUtils.getSusItem(context, model.getSuspensionTag());
            },
            indexBarData: ['↑', '☆', ...kIndexBarData],
            indexBarOptions: IndexBarOptions(
              needRebuild: true,
              ignoreDragCancel: true,
              downTextStyle: TextStyle(fontSize: 12, color: Colors.white),
              downItemDecoration:
              BoxDecoration(shape: BoxShape.circle, color: APPColors.app_main),
              indexHintWidth: 120 / 2,
              indexHintHeight: 100 / 2,
              indexHintDecoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(WidgetUtils.getImgPath('ic_index_bar_bubble_gray')),
                  fit: BoxFit.contain,
                ),
              ),
              indexHintAlignment: Alignment.centerRight,
              indexHintChildAlignment: Alignment(-0.25, 0.0),
              indexHintOffset: Offset(-20, 0),
            ),
          );
  }
}
