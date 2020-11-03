import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_message/model/user_model.dart';
import 'package:sqflite/sqlite_api.dart';

class PersonDbProvider extends BaseDbProvider {
  ///表名
  final String name = 'PresonInfo';

  final String columnId = "columnId";
  final String columnUUID = "id";
  final String columnMobile = "mobile";
  final String columnHeadImage = "headImage";

//  final String sql_createTable =
//      'CREATE TABLE user_table (id INTEGER PRIMARY KEY, username TEXT,pwd Text)';

  final String sql_query_count = 'SELECT COUNT(*) FROM PresonInfo';

  final String sql_query = 'SELECT * FROM PresonInfo';

  PersonDbProvider();

  @override
  tableName() {
    return name;
  }

  @override
  createTableString() {
    return '''
        create table $name (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnHeadImage text not null,
        $columnUUID text unique,
        $columnMobile text not null)
      ''';
  }

  ///查询数据库
  Future _getPersonProvider(Database db, String id) async {
    List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from $name where $columnUUID = $id");
    return maps;
  }

  ///插入到数据库
  Future insert(UserModel model) async {
    Database db = await getDataBase();
    var userProvider = await _getPersonProvider(db, model.uuid);
    if (userProvider != null) {
      ///删除数据
      await db.delete(name, where: "$columnUUID = ?", whereArgs: [model.uuid]);
    }
//    db.delete(table)
    return await db.rawInsert(
        "insert into $name ($columnUUID,$columnMobile,$columnHeadImage) values (?,?,?)",
        [model.uuid, model.mobile, model.headImage]);
  }

  ///更新数据库
  Future<void> update(UserModel model) async {
    Database database = await getDataBase();
    await database.rawUpdate(
        "update $name set $columnMobile = ?,$columnHeadImage = ? where $columnUUID= ?",
        [model.mobile, model.headImage, model.uuid]);
  }

  ///获取事件数据
  Future<UserModel> getPersonInfo(String id) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await _getPersonProvider(db, id);
    if (maps.length > 0) {
      print(maps.length);
      print(maps[0]);
      return UserModel.fromJson(maps[0]);
    }
    return null;
  }

  ///查询表格所有
  Future query(int maxResultCount, int skipCount) async {
    /*查询结果为 Map 集合*/
    Database db = await getDataBase();
//    db.insert(table, values)
    List<Map<String, dynamic>> list = await db.query(name,
        columns: [columnId, columnUUID, columnMobile, columnHeadImage],
        limit: maxResultCount,
        offset: skipCount);
    list.forEach((item) {
      print(item);
    });
  }

  ///查询数量
  Future<int> queryNum() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await db.rawQuery(sql_query_count);
    if (maps.length > 0) {
      print(maps.length);
      print(maps[0]);
      return maps[0]['COUNT(*)'];
    }
    return null;
  }
}
