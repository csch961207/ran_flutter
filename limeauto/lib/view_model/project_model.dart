
import 'package:limeauto/model/adminPostList_entity.dart';
import 'package:limeauto/model/categories_entity.dart';
import 'package:limeauto/model/postList_entity.dart';
import 'package:limeauto/model/tree.dart';
import 'package:limeauto/provider/view_state_list_model.dart';
import 'package:limeauto/provider/view_state_refresh_list_model.dart';
import 'package:limeauto/service/limeauto_repository.dart';
import 'package:limeauto/service/wan_android_repository.dart';

import 'favourite_model.dart';

class CategoryModel extends ViewStateListModel<CategoryItem> {
  @override
  Future<List<CategoryItem>> loadData() async {
    return await LimeAutoRepository.fetchProjectCategories();
  }
}

class AdminPostListModel extends ViewStateRefreshListModel<AdminPostItem> {
  @override
  Future<List<AdminPostItem>> loadData({int pageNum}) async {
    return await LimeAutoRepository.fetchAdminPostlist(pageNum);
  }
  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}

class TopListModel extends ViewStateListModel<PostsItem> {
  final int inDays;

  TopListModel(this.inDays);

  @override
  Future<List<PostsItem>> loadData() async {
    return await LimeAutoRepository.fetchReadRanking(inDays);
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}