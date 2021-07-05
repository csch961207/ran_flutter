import 'package:azlistview/azlistview.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMember_item_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/model/partyMembers_list_model.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/page/partyMember_list_page.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:ran_flutter_assets/ran_flutter_assets.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:provider/provider.dart';
import '../partyMember_repository.dart';
import '../partyMember_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


///
class PartyMemberPage extends StatefulWidget {
  @override
  _PartyMemberPageState createState() => _PartyMemberPageState();
}

class _PartyMemberPageState extends State<PartyMemberPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<PartyMemberItem> partyMemberItem = [];
  List<PartyMemberItem> topList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "党员",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
//          centerTitle: true,
        backgroundColor: APPColors.app_main,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            tooltip: '导入',
            icon: Icon(
              CupertinoIcons.cloud_upload,
              size: 21,
            ),
            color: Colors.white,
            onPressed: () async {
//              NavigatorUtils.push(context, MeetingRouter.addMeetingPage);
              var fileRes = await FilePicker.getFile(
                  type: FileType.ANY);
              if (fileRes != null) {
                EasyLoading.show();
                try {
                  print(fileRes.path);
                  ///传组织机构id
                  String organizationUnitId = Provider.of<DangjianViewModel>(context, listen: false).myOrganization?.organizationUnitId;
                  String blobName = await AssetsRepository.blobsUpload(
                      fileRes.path, "dangjian-partyMemberinfo-excel", organizationUnitId, "PartyMemberInfoExcel");
                  print("上传成功");
                  print(blobName);
                  int index = blobName.indexOf('/');
                  String code = await PartyMemberRepository.postImport( organizationUnitId, blobName.substring(index+1));
                  if (code == "200" || code == "204") {
                    await Provider.of<DangjianViewModel>(context,
                        listen: false)
                        .getPartyMemberList();
                    EasyLoading.dismiss();
                    print("上传成功");
                  }

                } catch (e, s) {
                  print(e.toString());
                  EasyLoading.dismiss();
                  getErrorTips(e, s, context: context);
                }
              }
            },
          ),
          IconButton(
            tooltip: '添加',
            icon: Icon(
              Icons.person_add_alt_1_outlined,
              size: 21,
            ),
            color: Colors.white,
            onPressed: () {
              NavigatorUtils.push(
                  context, PartyMemberRouter.addPartyMemberPage);
            },
          ),
        ],
      ),
      body: Consumer<DangjianViewModel>(
          builder: (context, dangjianViewModel, child) {
            print("重新渲染了");
            if(dangjianViewModel.partyMemberList.items == null || dangjianViewModel.partyMemberList.items.isEmpty){
              return ViewStateEmptyWidget(
                image: Image.asset(
                    ImageHelper.wrapAssets('no_data.png')),
                message: '',
                onPressed: () async {
                  ToastUtil.show("正在加载。。。");
                  await Provider.of<DangjianViewModel>(context, listen: false)
                      .getPartyMemberList();
                },
              );
            }
            setData(dangjianViewModel.partyMemberList);
            return PartyMemberListPage(partyMemberItem: partyMemberItem,);
      }),
    );
  }

  setData(PartyMemberList partyMemberList){
    partyMemberItem.clear();
    topList.clear();
    if(partyMemberList.items != null){
      partyMemberList.items.forEach((v) {
        partyMemberItem.add(PartyMemberItem.fromJson(v.toJson()));
      });
    }
//    topList.add(PartyMemberItem('Excel文件批量导入党员',
//        id: "1",
//        tagIndex: '↑',
//        bgColor: Colors.orange,
//        iconData: Icons.person_add));
    _handleList(partyMemberItem);
  }

  void _handleList(List<PartyMemberItem> list) {
//    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(partyMemberItem);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(partyMemberItem);

    // add topList.
    partyMemberItem.insertAll(0, topList);
  }


}
