
import 'package:flutter/material.dart';
import 'package:litecaijing/model/postList_entity.dart';
import 'package:litecaijing/ui/widget/load_image.dart';
import 'package:litecaijing/utils/relative_date_utils.dart';


/// 单图文章列表
class PostsNoGraphItem extends StatelessWidget {

  const PostsNoGraphItem({
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
//              SizedBox(
//                width: 12,
//              ),
            ],
          ),
        ],
      )
    );
  }
}