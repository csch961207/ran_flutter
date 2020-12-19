import 'package:flutter/cupertino.dart';
import 'package:limeauto/config/storage_manager.dart';
import 'package:limeauto/model/postList_entity.dart';
import 'package:limeauto/model/user.dart';
import 'package:limeauto/provider/view_state_refresh_list_model.dart';
import 'package:limeauto/service/limeauto_repository.dart';

import 'favourite_model.dart';

class ReadingRecordModel extends ChangeNotifier {
  List<String> _readingRecord = [];

  List<String>  get readingRecord => _readingRecord;

  List<PostsItem> postList;

  bool get hasUser => readingRecord != null;

  addReadingRecord(String readingRecord) {
    List readingRecordList = StorageManager.localStorage.getItem('readingRecord') != null ? StorageManager.localStorage.getItem('readingRecord') : [];
//    for(var i =0;i<readingRecordList.length;i++) {
//      _readingRecord.add(readingRecordList[i]);
//    }
//    _readingRecord.add(readingRecord);
    if(readingRecordList.length >= 30) {
      readingRecordList.removeAt(29);
    }
    readingRecordList.add(readingRecord);
    StorageManager.localStorage.setItem('readingRecord',readingRecordList);
    notifyListeners();
  }
}

class ReadingRecordListModel extends ViewStateRefreshListModel<PostsItem> {
  @override
  Future<List<PostsItem>> loadData({int pageNum}) async {
    return await LimeAutoRepository.fetchMultiples();
  }
  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}