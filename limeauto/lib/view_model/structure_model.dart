

import 'package:limeauto/model/postList_entity.dart';
import 'package:limeauto/provider/view_state_list_model.dart';
import 'package:limeauto/provider/view_state_refresh_list_model.dart';
import 'package:limeauto/service/limeauto_repository.dart';
import 'package:limeauto/service/wan_android_repository.dart';

import 'favourite_model.dart';

//class CategoryModel extends ViewStateListModel {
//  @override
//  Future<List> loadData() async {
//    return await LimeAutoRepository.fetchTreeCategories();
//  }
//}

class PostListModel extends ViewStateRefreshListModel<PostsItem> {
  final String cid;

  PostListModel(this.cid);

  @override
  Future<List<PostsItem>> loadData({int pageNum}) async {
    return await LimeAutoRepository.fetchArticles(pageNum, cid: cid);
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}

class RelatedArticleListModel extends ViewStateListModel<PostsItem> {
  final String cid;

  RelatedArticleListModel(this.cid);

  @override
  Future<List<PostsItem>> loadData() async {
    return await LimeAutoRepository.fetchRelatedArticleList(cid);
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}

///// 网址导航
//class NavigationSiteModel extends ViewStateListModel {
//  @override
//  Future<List> loadData() async {
//    return await WanAndroidRepository.fetchNavigationSite();
//  }
//}

