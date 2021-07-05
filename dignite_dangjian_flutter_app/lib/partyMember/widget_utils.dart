
import 'package:dignite_dangjian_flutter_app/partyMember/partyMember_repository.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/partyMember_router.dart';
import 'package:dignite_dangjian_flutter_app/res/app_colors.dart';
import 'package:dignite_dangjian_flutter_app/view_model/dangjian_view_model.dart';
import 'package:flutter/material.dart';
import 'package:ran_flutter_assets/ran_flutter_assets.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'model/partyMember_item_model.dart';
import 'package:provider/provider.dart';

class WidgetUtils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static Widget getSusItem(BuildContext context, String tag,
      {double susHeight = 40}) {
    if (tag == '★') {
      tag = '★ 热门城市';
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

//  static Widget getListItem(BuildContext context, CityModel model,
//      {double susHeight = 40}) {
//    return ListTile(
//      title: Text(model.name),
//      onTap: () {
//        LogUtil.e("onItemClick : $model");
//        Utils.showSnackBar(context, 'onItemClick : ${model.name}');
//      },
//    );
////    return Column(
////      mainAxisSize: MainAxisSize.min,
////      children: <Widget>[
////        Offstage(
////          offstage: !(model.isShowSuspension == true),
////          child: getSusItem(context, model.getSuspensionTag(),
////              susHeight: susHeight),
////        ),
////        ListTile(
////          title: Text(model.name),
////          onTap: () {
////            LogUtil.e("onItemClick : $model");
////            Utils.showSnackBar(context, 'onItemClick : ${model.name}');
////          },
////        )
////      ],
////    );
//  }

  static Widget getWeChatListItem(
      BuildContext context,
      PartyMemberItem model, {
        double susHeight = 40,
        Color defHeaderBgColor,
      }) {
    return getWeChatItem(context, model, defHeaderBgColor: defHeaderBgColor);
//    return Column(
//      mainAxisSize: MainAxisSize.min,
//      children: <Widget>[
//        Offstage(
//          offstage: !(model.isShowSuspension == true),
//          child: getSusItem(context, model.getSuspensionTag(),
//              susHeight: susHeight),
//        ),
//        getWeChatItem(context, model, defHeaderBgColor: defHeaderBgColor),
//      ],
//    );
  }

  static Widget getWeChatItem(
      BuildContext context,
      PartyMemberItem model, {
        Color defHeaderBgColor,
      }) {
    DecorationImage image;
//    if (model.img != null && model.img.isNotEmpty) {
//      image = DecorationImage(
//        image: CachedNetworkImageProvider(model.img),
//        fit: BoxFit.contain,
//      );
//    }
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4.0),
          color: model.bgColor ?? defHeaderBgColor,
          image: image,
        ),
        child: model.iconData != null
            ? Icon(
          model.iconData,
          color: Colors.white,
          size: 25,
        )
            : model.isUploadFace != null && model.isUploadFace ? Icon(
          Icons.person,
          color: APPColors.app_main,
          size: 25,
        ) : SizedBox(),
      ),
      title: Text(model.name,style: TextStyle(color: model.isDeparted != null && model.isDeparted ? Colors.grey : Colors.black),),
      onTap: () async {
        print("onItemClick : $model");
        if(model.id == "1") {
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
        } else {
          NavigatorUtils.push(context,
              '${PartyMemberRouter.partyMemberDetailsPage}?id=${model.id}');
        }
      },
    );
  }
}
