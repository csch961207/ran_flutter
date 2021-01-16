import 'package:dayansoft/model/eventFile.dart';
import 'package:dayansoft/utils/db_util.dart';
import 'package:sqflite/sqlite_api.dart';

import '../base_db_provider.dart';

class FileDbProvider extends BaseDbProvider {
  ///表名
  final String name = 'FileInfo';

  final String columnId = "columnId";
  final String columnEventId = "eventId";
  final String columnFilename = "filename";
  final String columnFilePath = "filePath";
  final String columnPhotoshootpositionLng = "photoshootpositionLng";
  final String columnPhotoshootpositionLat = "photoshootpositionLat";
  final String columnIsUpload = "isUpload";

  final String sql_query_count = 'SELECT COUNT(*) FROM FileInfo';

  final String sql_query = 'SELECT * FROM FileInfo';

  FileDbProvider();

  @override
  tableName() {
    return name;
  }

  @override
  createTableString() {
    return '''
        create table $name (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnEventId INTEGER,
        $columnFilename TEXT,
        $columnFilePath TEXT,
        $columnPhotoshootpositionLng REAL,
        $columnPhotoshootpositionLat REAL,
        $columnIsUpload INTEGER)
      ''';
  }


  /// 查询活动相关文件
  Future<List<EventFile>> getFilesByEventId(int eventId) async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(name,
        columns: [
          'eventId',
          'filename',
          'filePath',
          'photoshootpositionLng',
          'photoshootpositionLat',
          'isUpload'
        ],
        where: 'eventId = $eventId');
    return maps.map<EventFile>((item) => EventFile.fromJson(item)).toList();
  }

  /// 添加相关活动的文件
  Future insert(EventFile model) async {
    Database db = await getDataBase();
    await db.insert(name, model.toJson());
  }

  ///删除相关活动的文件
  Future<void> delete(EventFile model) async {
    Database db = await getDataBase();
    return await db.delete(name, where: 'eventId = ${model.eventId}');
  }

  ///更新相关活动的文件
  Future<void> update(EventFile model) async {
    Database db = await getDataBase();
    return await db.update(name, model.toJson(),
        where: 'eventId = ${model.eventId}');
  }
}
