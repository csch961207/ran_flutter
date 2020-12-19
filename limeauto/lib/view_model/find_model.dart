

import 'package:limeauto/model/blog_entity.dart';
import 'package:limeauto/model/entitiesList_entity.dart';
import 'package:limeauto/model/popularTags_entity.dart';
import 'package:limeauto/model/postList_entity.dart';
import 'package:limeauto/provider/view_state_refresh_list_model.dart';
import 'package:limeauto/service/limeauto_repository.dart';


class FindModel extends ViewStateRefreshListModel {
  List<PostsItem> _headlines;

  List<PostsItem> get headlines => _headlines;

  List<PopularTag> _popularTags;

  List<PopularTag> get popularTags => _popularTags;

  List<Blog> _blogs;

  List<Blog> get blogs => _blogs;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    futures.add(LimeAutoRepository.fetchHeadlines());
    futures.add(LimeAutoRepository.fetchPopularTags());
    futures.add(LimeAutoRepository.fetchBlogs());
    var result = await Future.wait(futures);
    _headlines = result[0];
    _popularTags = result[1];
    _blogs = result[2];
    return result[0];
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}
