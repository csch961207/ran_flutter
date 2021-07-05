
import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

class PartyMemberItem extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;

  Color bgColor;
  IconData iconData;

  String img;
  String id;
  String firstletter;
  bool isUploadFace;
  bool isDeparted;

  PartyMemberItem(this.name,{
    this.tagIndex,
    this.namePinyin,
    this.bgColor,
    this.iconData,
    this.img,
    this.id,
    this.firstletter,
    this.isUploadFace,
    this.isDeparted
  });

  PartyMemberItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        img = json['img'],
        id = json['id'],
        firstletter = json['firstletter'],
        isUploadFace = json['isUploadFace'],
        isDeparted = json['isDeparted'];


  Map<String, dynamic> toJson() => {
        'id': id,
    'name': name,
    'img': img,
        'firstletter': firstletter,
    'isUploadFace': isUploadFace,
    'isDeparted': isDeparted,
//        'tagIndex': tagIndex,
//        'namePinyin': namePinyin,
//        'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => json.encode(this);
}