import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ran_flutter_core/utils/toast_util.dart';

import 'package:url_launcher/url_launcher.dart';

class MapUtil {
  /// 高德地图
  static Future<bool> gotoAMap(longitude, latitude) async {
    var url =
        '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2';

    bool canLaunchUrl = await canLaunch(url);

    if (!canLaunchUrl) {
      ToastUtil.show('未检测到高德地图~');
      return false;
    }

    await launch(url);

    return true;
  }

  /// 腾讯地图
  static Future<bool> gotoTencentMap(longitude, latitude) async {
    var url =
        'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=$latitude,$longitude&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ';
    bool canLaunchUrl = await canLaunch(url);

    if (!canLaunchUrl) {
      ToastUtil.show('未检测到腾讯地图~');
      return false;
    }

    await launch(url);

    return canLaunchUrl;
  }

  /// 百度地图
  static Future<bool> gotoBaiduMap(longitude, latitude) async {
    var url =
        'baidumap://map/direction?destination=$latitude,$longitude&coord_type=bd09ll&mode=driving';

    bool canLaunchUrl = await canLaunch(url);

    if (!canLaunchUrl) {
      ToastUtil.show('未检测到百度地图~');
      return false;
    }

    await launch(url);

    return canLaunchUrl;
  }

  /// 苹果地图
  static Future<bool> gotoAppleMap(longitude, latitude) async {
    var url = 'http://maps.apple.com/?&daddr=$latitude,$longitude';

    bool canLaunchUrl = await canLaunch(url);

    if (!canLaunchUrl) {
      ToastUtil.show('打开失败~');
      return false;
    }

    await launch(url);
  }

  static mapMenu(BuildContext context, longitude, latitude) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,

      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 260,
          child: Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    MapUtil.gotoAMap(longitude, latitude);
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xffe5e5e5))),
                        ),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          '高德地图',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  )),
              GestureDetector(
                  onTap: () {
                    MapUtil.gotoTencentMap(longitude, latitude);
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xffe5e5e5)))),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          '腾讯地图',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  )),
              GestureDetector(
                  onTap: () {
                    MapUtil.gotoBaiduMap(longitude, latitude);
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xffe5e5e5)))),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          '百度地图',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  )),
              GestureDetector(
                  onTap: () {
                    MapUtil.gotoAppleMap(longitude, latitude);
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
//                          border: Border(
//                              bottom: BorderSide(
//                                  width: 1, color: Color(0xffe5e5e5))),
                        ),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          '苹果地图',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  )),
              Container(
                color: Color(0xFFf5f5f5),
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          '取消',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}
