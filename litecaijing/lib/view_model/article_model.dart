import 'package:flutter/cupertino.dart';
import 'package:litecaijing/model/articles_entity.dart';
import 'package:litecaijing/model/comments_entity.dart';
import 'package:litecaijing/provider/view_state_list_model.dart';
import 'package:litecaijing/provider/view_state_model.dart';
import 'package:litecaijing/provider/view_state_refresh_list_model.dart';
import 'package:litecaijing/service/litecaijing_repository.dart';
import 'package:litecaijing/view_model/readingRecord_model.dart';
import 'package:oktoast/oktoast.dart';

class ArticleModel extends ViewStateModel {
  ReadingRecordModel readingRecordModel = ReadingRecordModel();
  final String id;

  ArticleModel(this.id);

  ArticlesEntity article;


  initData() async {
    setBusy();
    try {
      article = await litecaijingRepository.fetchArticle(id);
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
    return await litecaijingRepository.fetchGetComments(id);
  }

  Future<List<CommentsItem>> shuaxin() async {
    setBusy();
    try {
      list = await litecaijingRepository.fetchGetComments(id);
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
      await litecaijingRepository.fetchAddComments(id,text);
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
      likeCount = await litecaijingRepository.fetchArticleLike(id);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
}
