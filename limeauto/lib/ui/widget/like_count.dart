import 'package:flutter/material.dart';
import 'package:limeauto/provider/provider_widget.dart';
import 'package:limeauto/view_model/article_model.dart';
import 'package:provider/provider.dart';

/// 点赞组件
class LikeCount extends StatefulWidget {
//  const LikeCount({Key key,@required this.id}) : super(key: key);
//
//  final String id;
  const LikeCount({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;

  @override
  LikeCountState createState() => LikeCountState();
}

class LikeCountState extends State<LikeCount> {
  int likeCount;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<ArticleLikeModel>(
        model: ArticleLikeModel(widget.id),
        builder: (context, model, child) {
          return GestureDetector(
              onTap: () {
                model.loadData();
              },
              child: Row(
                children: <Widget>[
                  Icon(
                      model.likeCount == null
                          ? Icons.favorite_border
                          : Icons.favorite,
                      color:
                          model.likeCount == null ? Colors.grey : Colors.red),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                      model.likeCount == null
                      ? '点赞 ' + ' '
                      : model.likeCount.toString(),
                      style: TextStyle(
                          color: Colors.grey
                      ),
                  )
                ],
              )
//            Row(
//              children: <Widget>[
//                Icon(
//                    provider.likeCount == null ? Icons.favorite_border : Icons.favorite,
//                    color: provider.likeCount == null ? Colours.text_gray : Colors.red
//                ),
//                Gaps.hGap4,
//                Text(
//                    provider.likeCount == null ? '点赞' : provider.likeCount.toString()
//                )
//              ],
//            ),
              );
        });
  }
}
