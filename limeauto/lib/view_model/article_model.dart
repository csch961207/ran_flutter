import 'package:flutter/cupertino.dart';
import 'package:limeauto/model/articles_entity.dart';
import 'package:limeauto/model/comments_entity.dart';
import 'package:limeauto/provider/view_state_list_model.dart';
import 'package:limeauto/provider/view_state_model.dart';
import 'package:limeauto/provider/view_state_refresh_list_model.dart';
import 'package:limeauto/service/limeauto_repository.dart';
import 'package:limeauto/view_model/readingRecord_model.dart';
import 'package:oktoast/oktoast.dart';

class ArticleModel extends ViewStateModel {
  ReadingRecordModel readingRecordModel = ReadingRecordModel();
  final String id;

  ArticleModel(this.id);

  ArticlesEntity article;


  initData() async {
    setBusy();
    try {
      article = await LimeAutoRepository.fetchArticle(id);
      readingRecordModel.addReadingRecord(id);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}

class CommentsListModel extends ViewStateRefreshListModel<CommentsItem> {
  final String id;

  CommentsListModel(this.id);

  @override
  Future<List<CommentsItem>> loadData({int pageNum}) async {
    return await LimeAutoRepository.fetchGetComments(id);
  }

  Future<List<CommentsItem>> shuaxin() async {
    setBusy();
    try {
      list = await LimeAutoRepository.fetchGetComments(id);
      setIdle();
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}


class AddCommentsModel extends ViewStateModel {

//  CommentsListModel commentsListModel;

  Future<CommentsItem> addComments(String id,String text) async {
    setBusy();
    try {
      await LimeAutoRepository.fetchAddComments(id,text);
      showToast('发表成功');
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
}


class ArticleLikeModel extends ViewStateModel {
  final String id;
  ArticleLikeModel(this.id);
  int likeCount;
  @override
  Future<int> loadData() async {
    setBusy();
    try {
      likeCount = await LimeAutoRepository.fetchArticleLike(id);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
}
