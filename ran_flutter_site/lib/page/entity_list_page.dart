import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_site/model/entities_model.dart';
import 'package:ran_flutter_site/site_repository.dart';
import 'package:ran_flutter_site/site_router.dart';
import 'package:ran_flutter_site/view_model/section_view_model.dart';
import 'package:ran_flutter_site/widget/entity_item.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

/// 条目列表页面
class EntityListPage extends StatefulWidget {
  /// 版块id
  final String sectionId;

  EntityListPage(this.sectionId);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<EntityListPage>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  bool get wantKeepAlive => true;

  int page = 1;
  List<Entity> entities = [];

  @override
  void initState() {
    super.initState();
    refresh();
  }

  refresh() async {
    this.page = 1;
    try {
      Entities entities = await SiteRepository.fetchEntities(widget.sectionId,
          maxResultCount: 20, skipCount: (this.page - 1) * 20);
      setState(() {
        this.entities = entities.items;
      });
    } catch (e) {
      print(e);
    }
  }

  loadMore() async {
    try {
      this.page++;
      Entities entities = await SiteRepository.fetchEntities(widget.sectionId,
          maxResultCount: 20, skipCount: (this.page - 1) * 20);
      setState(() {
        this.entities.addAll(entities.items);
      });
      if (entities.items.length == 0) {
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
    } catch (e) {
      print(e);
      _refreshController.loadFailed();
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(),
        footer: RefresherFooter(),
        onRefresh: refresh,
        onLoading: loadMore,
        enablePullUp: true,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: entities.length,
            itemBuilder: (context, index) {
              Entity item = entities[index];
              return InkWell(
                onTap: () {
                  Provider.of<SectionsViewModel>(context, listen: false)
                      .setFieldsCurrentSection(item.sectionId);
                  NavigatorUtils.push(
                      context, SiteRouter.entityPage + '?id=' + item.id,
                      transition: TransitionType.cupertino);
                },
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 13),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0xFFebebeb)))),
                    alignment: Alignment.centerLeft,
                    child: EntityItem(
                      title: item.title,
                      source: item?.section?.displayName ?? '',
                      publishTime: item.publishTime,
                    )),
              );
            }));
  }
}
