import 'package:ran_flutter_site/model/category_model.dart';
import 'package:ran_flutter_site/model/entities_model.dart';
import 'package:ran_flutter_site/model/section_model.dart';
import 'package:ran_flutter_site/site_api.dart';

class SiteRepository {
  /// 所有板块
  static Future<Sections> fetchSections() async {
    var response = await siteHttp.get('/api/site/sections');
    return Sections.fromJson(response.data);
  }

  /// 根据id获取单个板块
  static Future<Section> fetchSectionById(String id) async {
    var response = await siteHttp.get('/api/site/sections/${id}');
    return Section.fromJson(response.data);
  }

  /// 根据name获取单个板块
  static Future fetchSectionByName(String name) async {
    var response = await siteHttp.get('/api/site/sections/${name}');
    return Section.fromJson(response.data);
  }

  /// 根据查询条件获取分页条目
  static Future<Entities> fetchEntities(
      String sectionId,
      {String entityTypeId,
      String queryConditionsMd5,
      String creatorId,
      int maxResultCount,
      int skipCount}) async {
    var response = await siteHttp.get('/api/site/entities', queryParameters: {
      "SectionId": sectionId,
      "EntityTypeId": entityTypeId,
      "QueryConditionsMd5": queryConditionsMd5,
      "CreatorId": creatorId,
      "MaxResultCount": maxResultCount,
      "SkipCount": skipCount
    });
    return Entities.fromJson(response.data);
  }

  /// 根据id获取单个条目
  static Future fetchEntity(String id) async {
    var response = await siteHttp.get('/api/site/entities/${id}');
    return Entity.fromJson(response.data);
  }

  /// 根据ids获取多个条目
  static Future fetchManyEntity(List<String> ids) async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    var idsMap = ids.asMap();
    idsMap.forEach((key, value) {
      data[key.toString()] = value;
    });
    var response = await siteHttp.post('/api/site/entities/many', data: ids);
    return Entity.fromJson(response.data);
  }

  /// 根据name获取单个条目
  static Future fetchEntityByName(String sectionId, String entityName) async {
    var response =
        await siteHttp.get('/api/site/entities/${sectionId}/${entityName}');
    return Entity.fromJson(response.data);
  }

  /// 获取当前的上一个条目
  static Future fetchPrevEntity(String id) async {
    var response = await siteHttp.get('/api/site/entities/${id}/prev');
    return Entity.fromJson(response.data);
  }

  /// 获取当前的下一个条目
  static Future fetchNextEntity(String id) async {
    var response = await siteHttp.get('/api/site/entities/{$id}/next');
    return Entity.fromJson(response.data);
  }

  /// 根据ids获取多个分类
  static Future fetchManyCategories(List<String> ids) async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    var idsMap = ids.asMap();
    idsMap.forEach((key, value) {
      data[key.toString()] = value;
    });
    var response = await siteHttp.post('/api/site/Categories/many', data: ids);
    return Categories.fromJson(response.data);
  }

  /// 根据分类组名来获取相应的所有分类
  static Future fetchCategoriesByGroupName(String groupName) async {
    var response = await siteHttp.get('/api/site/Categories/${groupName}/find');
    return Categories.fromJson(response.data);
  }

  /// 根据分类组id来获取相应的所有分类
  static Future fetchCategoriesById(String groupId) async {
    var response = await siteHttp.get('/api/site/Categories/${groupId}/find');
    return Categories.fromJson(response.data);
  }

  /// 根据分类code来获取相应的分类
  static Future fetchCategoryByCode(String code) async {
    var response = await siteHttp.get('/api/site/Categories/byCode/${code}');
    return Category.fromJson(response.data);
  }

  /// 根据分类id来获取相应的分类
  static Future fetchCategoryById(String id) async {
    var response = await siteHttp.get('/api/site/Categories/${id}');
    return Category.fromJson(response.data);
  }
}
