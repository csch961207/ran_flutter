
import 'package:flutter/material.dart';
import 'package:limeauto/model/postList_entity.dart';
import 'package:limeauto/ui/widget/load_image.dart';
import 'package:limeauto/utils/relative_date_utils.dart';


/// 单图文章列表
class PostsSingleGraphItem extends StatelessWidget {

  const PostsSingleGraphItem({
    Key key,
    @required this.postItem,
  }) : super(key: key);

  final PostsItem postItem;

//  PostsItem postItem = widget.posItem

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 2, 5, 0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      postItem.media.title,
                  style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 6),
                    SizedBox(
                      height: 9,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            postItem.blog.name,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                          ),
                        ),
                        Text(
                          RelativeDateFormat.format(DateTime.parse(postItem.publishTime)),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Padding (
                padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                  child: LoadImage(postItem.media.coverImages[0], height: 70.0, width: 110.0, fit: BoxFit.fill,holderImg: 'none'),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}