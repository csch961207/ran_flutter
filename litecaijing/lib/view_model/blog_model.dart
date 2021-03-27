

import 'package:litecaijing/model/blog_entity.dart';
import 'package:litecaijing/model/entitiesList_entity.dart';
import 'package:litecaijing/provider/view_state_refresh_list_model.dart';
import 'package:litecaijing/service/litecaijing_repository.dart';

import 'favourite_model.dart';

class BlogModel extends ViewStateRefreshListModel {
  final String blogId;

  BlogModel(this.blogId);
  Blog _blog;

  Blog get blog => _blog;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures.add(litecaijingRepository.fetchBlog(blogId));
//      futures.add(WanAndroidRepository.fetchTopArticles());
    }
    futures.add(litecaijingRepository.fetchPostsListByBlog(pageNum,blogId));

    var result = await Future.wait(futures);
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _blog = result[0];
      return result[1];
    } else {
      return result[0];
    }
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}
