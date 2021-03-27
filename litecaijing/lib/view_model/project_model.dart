
import 'package:litecaijing/model/adminPostList_entity.dart';
import 'package:litecaijing/model/categories_entity.dart';
import 'package:litecaijing/model/postList_entity.dart';
import 'package:litecaijing/model/tree.dart';
import 'package:litecaijing/provider/view_state_list_model.dart';
import 'package:litecaijing/provider/view_state_model.dart';
import 'package:litecaijing/provider/view_state_refresh_list_model.dart';
import 'package:litecaijing/service/litecaijing_repository.dart';
import 'package:litecaijing/service/wan_android_repository.dart';

import 'favourite_model.dart';

class CategoryModel extends ViewStateListModel<CategoryItem> {
  @override
  Future<List<CategoryItem>> loadData() async {
    return await litecaijingRepository.fetchProjectCategories();
  }
}

class AdminPostListModel extends ViewStateRefreshListModel<AdminPostItem> {
  @override
  Future<List<AdminPostItem>> loadData({int pageNum}) async {
    return await litecaijingRepository.fetchAdminPostlist(pageNum);
  }
  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}

class TopListModel extends ViewStateModel {
  final int inDays;

  List<PostsItem> list = [];

  TopListModel(this.inDays);

  initData() async {
    setBusy();
    try {
      list = await litecaijingRepository.fetchReadRanking(inDays);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

}

class NewsFlashModel extends ViewStateRefreshListModel<PostsItem> {
  @override
  Future<List<PostsItem>> loadData({int pageNum}) async {
    return await litecaijingRepository.fetchNewsFlashModel(pageNum);
  }
  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}