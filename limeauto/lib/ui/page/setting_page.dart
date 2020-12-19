import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:launch_review/launch_review.dart';
import 'package:limeauto/generated/l10n.dart';
import 'package:limeauto/view_model/locale_model.dart';
import 'package:limeauto/view_model/theme_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).setting),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(S.of(context).settingFont),
                      Text(
                        ThemeModel.fontName(
                            Provider.of<ThemeModel>(context,listen: false).fontIndex,
                            context),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.font_download,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: ThemeModel.fontValueList.length,
                        itemBuilder: (context, index) {
                          var model = Provider.of<ThemeModel>(context,listen: false);
                          return RadioListTile(
                            value: index,
                            onChanged: (index) {
                              model.switchFont(index);
                            },
                            groupValue: model.fontIndex,
                            title: Text(ThemeModel.fontName(index, context)),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        S.of(context).settingLanguage,
                        style: TextStyle(),
                      ),
                      Text(
                        LocaleModel.localeName(
                            Provider.of<LocaleModel>(context).localeIndex,
                            context),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.public,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: LocaleModel.localeValueList.length,
                        itemBuilder: (context, index) {
                          var model = Provider.of<LocaleModel>(context);
                          return RadioListTile(
                            value: index,
                            onChanged: (index) {
                              model.switchLocale(index);
                            },
                            groupValue: model.localeIndex,
                            title: Text(LocaleModel.localeName(index, context)),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(S.of(context).rate),
                  onTap: () async {
                    LaunchReview.launch(
                        androidAppId: "com.example.limeauto",
                        iOSAppId: "1503277085");
                  },
                  leading: Icon(
                    Icons.star,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(S.of(context).feedback),
                  onTap: () async {
                    var url =
                        'mailto:1107554233@qq.com?subject=Feedback&body=feedback';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      showToast(S.of(context).githubIssue);
                      await Future.delayed(Duration(seconds: 1));
                      launch(
                          '',
                          forceSafariVC: false);
                    }
                  },
                  leading: Icon(
                    Icons.feedback,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
