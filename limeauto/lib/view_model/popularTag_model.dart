
import 'package:limeauto/model/popularTags_entity.dart';
import 'package:limeauto/provider/view_state_refresh_list_model.dart';
import 'package:limeauto/service/limeauto_repository.dart';


class PopularTagModel extends ViewStateRefreshListModel {
  final String name;

  PopularTagModel(this.name);
  PopularTag _popularTag;

  PopularTag get popularTag => _popularTag;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures.add(LimeAutoRepository.fetchPopularTag(name));
//      futures.add(WanAndroidRepository.fetchTopArticles());
    }
    futures.add(LimeAutoRepository.fetchPostsListByTag(pageNum,name));

    var result = await Future.wait(futures);
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _popularTag = result[0];
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
