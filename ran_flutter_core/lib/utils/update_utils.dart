import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ran_flutter_core/config/routers/fluro_navigator.dart';
import 'package:ran_flutter_core/utils/utils.dart';
import 'package:ran_flutter_core/widget/base_dialog.dart';
import 'package:ran_flutter_core/widget/photo_view_simple_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateUtil {
  static showUpdateDialog(
      BuildContext context, String title, String content, String url) {
    showElasticDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BaseDialog(
            title: title,
            confirmText: "立即升级",
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 2.5),
              child: Scrollbar(
                  thickness: 5,
                radius: Radius.circular(5),
                child: ListView.builder(
                  reverse: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Html(
                        data: content,
                        style: {},
                        onLinkTap: (url) {
                          // open url in a webview
                          NavigatorUtils.goWebViewPage(context, url);
                        },
                        onImageTap: (src) {
                          // Display the image in large form.
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new PhotoViewSimpleScreen(
                                    imageProvider: NetworkImage(src),
                                    heroTag: 'simple',
                                  )));
                        },
                      ),
                    );
                  },
                  itemCount: 1,
                ),
              ),
            ),
            onPressed: () {
              NavigatorUtils.goBack(context);
              launch(url, forceSafariVC: false);
            },
          );
        });
  }
}
