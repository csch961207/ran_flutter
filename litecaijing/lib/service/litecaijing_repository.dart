import 'package:dio/dio.dart';
import 'package:litecaijing/config/net/litecaijing_api.dart';
import 'package:litecaijing/config/storage_manager.dart';
import 'package:litecaijing/model/adminPostList_entity.dart';
import 'package:litecaijing/model/articles_entity.dart';
import 'package:litecaijing/model/blog_entity.dart';
import 'package:litecaijing/model/categories_entity.dart';
import 'package:litecaijing/model/comments_entity.dart';
import 'package:litecaijing/model/entitiesList_entity.dart';
import 'package:litecaijing/model/popularTags_entity.dart';
import 'package:litecaijing/model/postList_entity.dart';
import 'package:litecaijing/model/user.dart';
import 'package:litecaijing/service/http_api.dart';
import 'dart:convert';

class litecaijingRepository {
  // 轮播
  static Future fetchBanners() async {
    var response = await http.get(HttpApi.banner);
    return response.data["items"]
        .map<EntitiesItem>((item) => EntitiesItem.fromJson(item))
        .toList();
    EntitiesListEntity.fromJson(response.data);
  }

  // 头条
  static Future fetchHeadlines() async {
    var entities = await http.get(HttpApi.headlines);
    var entitie = EntitiesItem.fromJson(entities.data['items'][0]);
    List<String> list = [];
    FieldValues postFieldValue = entitie.fieldValues.firstWhere((fieldValue) =>
        fieldValue.fieldId == '6cf5c615-4f95-44ef-dcb9-39fac6184c95');
    jsonDecode(postFieldValue.maxTextValue).forEach((item) => list.add(item));
    var response = await http.post(HttpApi.multiples, data: list);
    return response.data["items"]
        .map<PostsItem>((item) => PostsItem.fromJson(item))
        .toList();
  }

  // 话题
  static Future fetchPopularTags() async {
    var response = await http.get(HttpApi.popularTags);
    return response.data["items"]
        .map<PopularTag>((item) => PopularTag.fromJson(item))
        .toList();
    EntitiesListEntity.fromJson(response.data);
  }

  // 作者列表
  static Future fetchBlogs() async {
    Map<String, String> params = Map();
    params["MaxResultCount"] = "5";
    var response = await http.get(HttpApi.blogs, queryParameters: params);
    return response.data["items"]
        .map<Blog>((item) => Blog.fromJson(item))
        .toList();
  }

  // 作者
  static Future fetchBlog(String blogId) async {
    var response = await http.get(HttpApi.blog + blogId);
    return Blog.fromJson(response.data);
  }

  // 作者文章列表
  static Future fetchPostsListByBlog(int pageNum, String blogId) async {
    Map<String, String> params = Map();
    params["SkipCount"] = (pageNum * 20).toString();
    params["MaxResultCount"] = "20";
    params["mediaTypeName"] = "article";
    var response =
        await http.get(HttpApi.postsByBlog + blogId, queryParameters: params);
    return response.data["items"]
        .map<PostsItem>((item) => PostsItem.fromJson(item))
        .toList();
  }

  // 话题
  static Future fetchPopularTag(String name) async {
    var response = await http.get(HttpApi.tagsFind + name);
    return PopularTag.fromJson(response.data);
  }

  // 话题文章列表
  static Future fetchPostsListByTag(int pageNum, String name) async {
    Map<String, String> params = Map();
    params["SkipCount"] = (pageNum * 20).toString();
    params["MaxResultCount"] = "20";
    params["mediaTypeName"] = "article";
    var response =
        await http.get(HttpApi.postsByTag + name, queryParameters: params);
    return response.data["items"]
        .map<PostsItem>((item) => PostsItem.fromJson(item))
        .toList();
  }

  // 文章列表
  static Future fetchArticles(int pageNum, {String cid}) async {
    Map<String, String> params = Map();
    params["categoryId"] = cid != null ? cid : null;
    params["mediaTypeName"] = "article";
    params["MaxResultCount"] = "20";
    params["SkipCount"] = (pageNum * 20).toString();
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http.get(HttpApi.posts, queryParameters: params);
    return response.data["items"]
        .map<PostsItem>((item) => PostsItem.fromJson(item))
        .toList();
  }

  // 文章
  static Future fetchArticle(String id) async {
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http.get(
      HttpApi.article + id,
    );
    return ArticlesEntity.fromJson(response.data);
  }

  // 查询
  static Future fetchMultiples() async {
    var readingRecord = StorageManager.localStorage.getItem('readingRecord');
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http.post(HttpApi.multiples,
        data: readingRecord != null ? readingRecord : []);
    List<PostsItem> posts = response.data["items"]
        .map<PostsItem>((item) => PostsItem.fromJson(item))
        .toList();
    return posts.where((post) => post.mediaType == "article").toList();
  }

  // 博文管理
  static Future fetchAdminPostlist(int pageNum) async {
    Map<String, String> params = Map();
    params["MediaType"] = "article";
    params["MaxResultCount"] = "20";
    params["SkipCount"] = (pageNum * 20).toString();
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http.get(HttpApi.adminPosts, queryParameters: params);
    return response.data["items"]
        .map<AdminPostItem>((item) => AdminPostItem.fromJson(item))
        .toList();
  }

// 24小时热门快讯
  static Future fetchNewsFlashModel(int pageNum) async {
    Map<String, String> params = Map();
    params["MaxResultCount"] = "20";
    params["SkipCount"] = (pageNum * 20).toString();
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http.get(HttpApi.newsFlash, queryParameters: params);
    return response.data["items"]
        .map<PostsItem>((item) => PostsItem.fromJson(item))
        .toList();
  }

  // 点赞
  static Future fetchArticleLike(String id) async {
    var response = await http.post(HttpApi.like + id);
    return response.data;
//      CategoriesEntity.fromJson(response.data);
  }

  // 评论
  static Future fetchGetComments(String id) async {
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http.get(
      HttpApi.getComments + id,
    );
    return response.data["items"]
        .map<CommentsItem>((item) => CommentsItem.fromJson(item))
        .toList();
  }

  // 添加评论
  static Future fetchAddComments(String id, String text) async {
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http
        .post(HttpApi.addComments, data: {"postId": id, "text": text});
    return CommentsItem.fromJson(response.data);
  }

// 相关推荐
  static Future fetchRelatedArticleList(String cid) async {
    Map<String, String> params = Map();
    params["categoryId"] = cid != null ? cid : null;
    params["mediaTypeName"] = "article";
    params["MaxResultCount"] = "5";
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http.get(HttpApi.posts, queryParameters: params);
    return response.data["items"]
        .map<PostsItem>((item) => PostsItem.fromJson(item))
        .toList();
  }

  // 热门
  static Future fetchReadRanking(int inDays) async {
    Map<String, String> params = Map();
    params["inDays"] = inDays != null ? inDays.toString() : null;
    params["mediaTypeName"] = "article";
    params["MaxResultCount"] = "10";
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http.get(HttpApi.readRanking, queryParameters: params);
    return response.data["items"]
        .map<PostsItem>((item) => PostsItem.fromJson(item))
        .toList();
  }

  // 分类
  static Future fetchProjectCategories() async {
    var response = await http.get('/api/blogging/categories',
        queryParameters: {"mediaTypeName": "article"});
    return response.data["items"]
        .map<CategoryItem>((item) => CategoryItem.fromJson(item))
        .toList();
//      CategoriesEntity.fromJson(response.data);
  }

  // 搜索结果
  static Future fetchSearchResult({key = "", int pageNum = 0}) async {
    Map<String, String> params = Map();
    params["mediaTypeName"] = "article";
    params["keyword"] = key != null ? key : null;
    params["SkipCount"] = (pageNum * 20).toString();
    params["MaxResultCount"] = "20";
    var response = await http.get<Map>(HttpApi.search, queryParameters: params);
    return response.data["items"]
        .map<PostsItem>((item) => PostsItem.fromJson(item))
        .toList();
  }

  /// 登录
  /// [Http._init] 添加了拦截器 设置了自动cookie.
  static Future login(String username, String password) async {
    FormData formData = new FormData.fromMap({
      "grant_type": "password",
      "scope": "Abpone",
      "username": username,
      "password": password,
      "client_id": "Abpone_ConsoleTestApp",
      "client_secret": "1q2w3e*"
    });
    var response = await accountHttp.post<Map>('/connect/token', data: formData);
    return LoginRes.fromJsonMap(response.data);
  }

  ///  个人信息
  static Future profile() async {
    var response = await accountHttp.get<Map>('/api/identity/my-profile');
    return User.fromJsonMap(response.data);
  }

  /// 注册
  static Future register(
      String username, String password, String rePassword) async {
    var response = await accountHttp.post<Map>('/user/register', queryParameters: {
      'username': username,
      'password': password,
      'repassword': rePassword,
    });
    return User.fromJsonMap(response.data);
  }
}
