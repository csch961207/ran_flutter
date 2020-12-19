import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ran_flutter_fields/ran_flutter_fields.dart';
import 'package:ran_flutter_site/model/entities_model.dart';
import 'package:ran_flutter_site/site_repository.dart';
import 'package:ran_flutter_site/view_model/section_view_model.dart';
import 'package:provider/provider.dart';
import 'package:ran_flutter_site/widget/field_CKEditor5.dart';

/// 条目详情
class EntityPage extends StatefulWidget {
  const EntityPage({Key key, this.id}) : super(key: key);
  final String id;
  @override
  EntityPageState createState() => EntityPageState();
}

class EntityPageState extends State<EntityPage>
    with AutomaticKeepAliveClientMixin {
  final controller = TextEditingController();
  int likeCount;
  bool isClientInstalled = false;
  bool isIOS = false;
  ScrollController mCommentScrollController = new ScrollController();

  Entity entity = new Entity();

  @override
  void initState() {
    super.initState();
    getEntity();
  }

  getEntity() async {
    try {
      Entity entity = await SiteRepository.fetchEntity(widget.id);
      setState(() {
        this.entity = entity;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (entity.id != null) {
      Field field = Provider.of<SectionsViewModel>(context, listen: false)
          .fields
          .firstWhere((item) => item.name == 'zuzhidongtai_content');
      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: new AppBar(
                title: Text('详情'),
              ),
              body: SafeArea(
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.9,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    entity.title != null ? entity.title : '',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            FieldCkEditor(
                              field: field,
                              fieldValue: entity.fieldValues.firstWhere(
                                  (item) => item.fieldId == field.id,
                                  orElse: () => new FieldValue()),
                            ),
                            Container(
                              height: 45,
//                        color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )));
    }
    return Container(
      child: Text('占位符'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
