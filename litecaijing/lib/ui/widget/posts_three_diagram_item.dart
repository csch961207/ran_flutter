
import 'package:flutter/material.dart';
import 'package:litecaijing/model/postList_entity.dart';
import 'package:litecaijing/ui/widget/load_image.dart';
import 'package:litecaijing/utils/relative_date_utils.dart';



/// 三图文章列表
class PostsThreeDiagramItem extends StatelessWidget {

  const PostsThreeDiagramItem({
    Key key,
    @required this.postItem,
  }) : super(key: key);

  final PostsItem postItem;

//  PostsItem postItem = widget.posItem

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:
      EdgeInsets.fromLTRB(5, 2, 5, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  postItem.media.title,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding (
                    padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(0),
                      ),
                      child: LoadImage(postItem.media.coverImages[0], height: 70.0, fit: BoxFit.fill,),
                    ),
                  )
              ),
              Expanded(
                  child: Padding (
                    padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      child: LoadImage(postItem.media.coverImages[1], height: 70.0, fit: BoxFit.fill,),
                    ),
                  )
              ),
              Expanded(
                  child: Padding (
                    padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(4),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(4),
                      ),
                      child: LoadImage(postItem.media.coverImages[2], height: 70.0, fit: BoxFit.fill,),
                    ),
                  )
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
//                    postItem.readCount.toString() + '次阅读' +  ' / ' +
                        postItem.blog.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                ),
              ),
              Text(
                RelativeDateFormat.format(DateTime.parse(postItem.publishTime)),
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}