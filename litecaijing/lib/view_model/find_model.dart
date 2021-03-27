

import 'package:litecaijing/model/blog_entity.dart';
import 'package:litecaijing/model/entitiesList_entity.dart';
import 'package:litecaijing/model/popularTags_entity.dart';
import 'package:litecaijing/model/postList_entity.dart';
import 'package:litecaijing/provider/view_state_model.dart';
import 'package:litecaijing/provider/view_state_refresh_list_model.dart';
import 'package:litecaijing/service/litecaijing_repository.dart';


class FindModel extends ViewStateModel {
  List<PostsItem> _headlines;

  List<PostsItem> get headlines => _headlines;

  List<PopularTag> _popularTags;

  List<PopularTag> get popularTags => _popularTags;

  List<Blog> _blogs;

  List<Blog> get blogs => _blogs;

  initData() async {
    setBusy();
    try {
      List<Future> futures = [];
      futures.add(litecaijingRepository.fetchHeadlines());
      futures.add(litecaijingRepository.fetchPopularTags());
      futures.add(litecaijingRepository.fetchBlogs());
      var result = await Future.wait(futures);
      _headlines = result[0];
      _popularTags = result[1];
      _blogs = result[2];
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }

  }
}
