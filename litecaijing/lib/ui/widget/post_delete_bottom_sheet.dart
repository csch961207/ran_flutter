import 'package:flutter/material.dart';


class PostDeleteBottomSheet extends StatelessWidget {

  const PostDeleteBottomSheet({
    Key key,
    @required this.onTapDelete,
  }): super(key: key);

  final Function onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SizedBox(
            height: 162,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 52.0,
                  child: const Center(
                    child: const Text(
                      "是否确认删除，防止错误操作",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Divider(height: 1,),
                SizedBox(
                  height: 54.0,
                  width: double.infinity,
                  child: FlatButton(
                    textColor: Theme.of(context).errorColor,
                    child: const Text("确认删除", style: TextStyle(fontSize: 18)),
                    onPressed: (){
                      Navigator.pop(context);
                      onTapDelete();
                    },
                  ),
                ),
                Divider(height: 1,),
                SizedBox(
                  height: 54.0,
                  width: double.infinity,
                  child: FlatButton(
                    textColor: Colors.grey,
                    child: const Text("取消", style: TextStyle(fontSize: 18)),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}