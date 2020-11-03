import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class SqlManager {
  static const _VERSION = 1;

  static const _NAME = "ran.db";

  static Database _database;

  ///初始化
  static init() async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, _NAME);

    _database = await openDatabase(
      path,
      version: _VERSION,
      onCreate: (Database db, int version) async {},
      onUpgrade: _onUpgrade,
    );
  }

  static FutureOr<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();
//    if (oldVersion == 1) {
//      batch.execute('alter table PresonInfo add id text unique');
//    }
    oldVersion++;
    //升级后版本还低于当前版本，继续递归升级
    if (oldVersion < newVersion) {
      _onUpgrade(db, oldVersion, newVersion);
    }
    await batch.commit();
  }

  ///判断表是否存在
  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  ///获取当前数据库对象
  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  ///关闭
  static close() {
    _database?.close();
    _database = null;
  }
}
