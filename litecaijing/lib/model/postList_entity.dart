import 'package:litecaijing/model/blog_entity.dart';

class PostListEntity {
  int totalCount;
  List<PostsItem> items;

  PostListEntity({this.items});

  PostListEntity.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = new List<PostsItem>();
      (json['items'] as List).forEach((v) {
        items.add(new PostsItem.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WebPage {
  String url;
  String title;
  String description;
  String cover;

  WebPage({this.url, this.title, this.description, this.cover});

  WebPage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
    description = json['description'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['title'] = this.title;
    data['description'] = this.description;
    data['cover'] = this.cover;
    return data;
  }
}

class Media {
  List<String> coverImages;
  String title;
  String author;
  String introductory;
  String content;
  String id;
  String mediaType;
  List<String> images;
  WebPage webPage;

  Media(
      {this.coverImages,
      this.title,
      this.author,
      this.introductory,
      this.content,
      this.id,
      this.mediaType,this.images,this.webPage});

  Media.fromJson(Map<String, dynamic> json) {
    if (json['coverImages'] != null) {
      coverImages = new List<String>();
      (json['coverImages'] as List).forEach((v) {
        coverImages.add(v);
      });
    }
    title = json['title'];
    author = json['author'];
    introductory = json['introductory'];
    content = json['content'];
    id = json['id'];
    mediaType = json['mediaType'];
    if (json['images'] != null) {
      images = new List<String>();
      (json['images'] as List).forEach((v) {
        images.add(v);
      });
    }
    webPage =
    json['webPage'] != null ? new WebPage.fromJson(json['webPage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coverImages'] = this.coverImages;
    if (this.coverImages != null) {
      data['coverImages'] = this.coverImages.map((v) => v).toList();
    }
    data['title'] = this.title;
    data['author'] = this.author;
    data['introductory'] = this.introductory;
    data['content'] = this.content;
    data['id'] = this.id;
    data['mediaType'] = this.mediaType;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v).toList();
    }
    if (this.webPage != null) {
      data['webPage'] = this.webPage.toJson();
    }
    return data;
  }
}

class PostsItem {
//  /// <summary>
//  /// 文章
//  /// </summary>
//  Articles,
//
//  /// <summary>
//  /// 视频
//  /// </summary>
//  Videos,
//
//  /// <summary>
//  /// 图册
//  /// </summary>
//  Galleries
  Blog blog;
  int postType;
//  List<String> coverImages;
//  String title;
  String publishTime;
  int readCount;
  int commentCount;
  int likeCount;
  int favoriteCount;
  List<String> tagNames;
  String id;
  Media media;
  String mediaType;

  PostsItem(
      {this.blog,
      this.postType,
//        this.coverImages,
//        this.title,
      this.publishTime,
      this.readCount,
      this.commentCount,
      this.likeCount,
      this.favoriteCount,
      this.tagNames,
      this.id,
      this.media,
      this.mediaType});

  PostsItem.fromJson(Map<String, dynamic> json) {
    if (json['blog'] != null) {
      blog = new Blog.fromJson(json['blog']);
    }
    postType = json['postType'];
//    if (json['coverImages'] != null) {
//      coverImages = new List<String>();(json['coverImages'] as List).forEach((v) { coverImages.add(v); });
//    }
    if (json['tagNames'] != null) {
      tagNames = new List<String>();
      (json['tagNames'] as List).forEach((v) {
        tagNames.add(v);
      });
    }
//    title = json['title'];
    publishTime = json['publishTime'];
    readCount = json['readCount'];
    commentCount = json['commentCount'];
    likeCount = json['likeCount'];
    favoriteCount = json['favoriteCount'];
    id = json['id'];
    mediaType = json['mediaType'];
    if (json['media'] != null) {
      media = new Media.fromJson(json['media']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blog != null) {
      data['blog'] = this.blog.toJson();
    }
    data['postType'] = this.postType;
//    if (this.coverImages != null) {
//      data['coverImages'] =  this.coverImages.map((v) => v).toList();
//    }
    if (this.tagNames != null) {
      data['tagNames'] = this.tagNames.map((v) => v).toList();
    }
//    data['title'] = this.title;
    data['publishTime'] = this.publishTime;
    data['readCount'] = this.readCount;
    data['commentCount'] = this.commentCount;
    data['likeCount'] = this.likeCount;
    data['favoriteCount'] = this.favoriteCount;
    data['id'] = this.id;
    data['mediaType'] = this.mediaType;
    if (this.media != null) {
      data['media'] = this.media.toJson();
    }
    return data;
  }
}

class Article {
  String author;
  String introductory;
  String content;

  Article({this.author, this.introductory, this.content});

  Article.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    introductory = json['introductory'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['introductory'] = this.introductory;
    data['content'] = this.content;
    return data;
  }
}
