import 'package:limeauto/model/banner.dart';
import 'package:limeauto/model/entitiesList_entity.dart';
import 'package:limeauto/provider/view_state_refresh_list_model.dart';
import 'package:limeauto/service/limeauto_repository.dart';
import 'package:limeauto/service/wan_android_repository.dart';

import 'favourite_model.dart';

class HomeModel extends ViewStateRefreshListModel {
  List<EntitiesItem> _banners;

  List<EntitiesItem> get banners => _banners;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures.add(LimeAutoRepository.fetchBanners());
//      futures.add(WanAndroidRepository.fetchTopArticles());
    }
    futures.add(LimeAutoRepository.fetchArticles(pageNum));

    var result = await Future.wait(futures);
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _banners = result[0];
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
