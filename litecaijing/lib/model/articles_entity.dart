

import 'package:litecaijing/model/blog_entity.dart';
import 'package:litecaijing/model/postList_entity.dart';

class ArticlesEntity {
  Blog blog;
  String categoryId;
  int postType;
//  List<String> coverImages;
//  String title;
  int auditedStatus;
  int publicationStatus;
  String publishTime;
  int readCount;
  int commentCount;
  int likeCount;
  int favoriteCount;
  Article article;
  String url;
//  Video video;
//  Gallery gallery;
//  Writer writer;
//  List<String> tagNames;
  String id;
  Media media;

  ArticlesEntity(
      {
        this.blog,
        this.categoryId,
        this.postType,
//        this.coverImages,
//        this.title,
        this.auditedStatus,
        this.publicationStatus,
        this.publishTime,
        this.readCount,
        this.commentCount,
        this.likeCount,
        this.favoriteCount,
        this.article,
        this.url,
//        this.video,
//        this.gallery,
//        this.writer,
//        this.tagNames,
        this.id,
      this.media});

  ArticlesEntity.fromJson(Map<String, dynamic> json) {
    if (json['blog'] != null) {
      blog = new Blog.fromJson(json['blog']);
    }
    categoryId = json['categoryId'];
    postType = json['postType'];
//    if (json['coverImages'] != null) {
//      coverImages = new List<String>();(json['coverImages'] as List).forEach((v) { coverImages.add(v); });
//    }
//    title = json['title'];
    auditedStatus = json['auditedStatus'];
    publicationStatus = json['publicationStatus'];
    publishTime = json['publishTime'];
    readCount = json['readCount'];
    commentCount = json['commentCount'];
    likeCount = json['likeCount'];
    favoriteCount = json['favoriteCount'];
    if (json['article'] != null) {
      article = new Article.fromJson(json['article']);
    }
    url = json['url'];
//    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
//    gallery =
//    json['gallery'] != null ? new Gallery.fromJson(json['gallery']) : null;
//    writer =
//    json['writer'] != null ? new Writer.fromJson(json['writer']) : null;
//    tagNames = json['tagNames'].cast<String>();
    id = json['id'];
    if (json['media'] != null) {
      media = new Media.fromJson(json['media']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blog != null) {
      data['blog'] = this.blog.toJson();
    }
    data['categoryId'] = this.categoryId;
    data['postType'] = this.postType;
//    if (this.coverImages != null) {
//      data['coverImages'] =  this.coverImages.map((v) => v).toList();
//    }
//    data['title'] = this.title;
    data['auditedStatus'] = this.auditedStatus;
    data['publicationStatus'] = this.publicationStatus;
    data['publishTime'] = this.publishTime;
    data['readCount'] = this.readCount;
    data['commentCount'] = this.commentCount;
    data['likeCount'] = this.likeCount;
    data['favoriteCount'] = this.favoriteCount;
    if (this.article != null) {
      data['article'] = this.article.toJson();
    }
    data['url'] = this.url;
//    if (this.video != null) {
//      data['video'] = this.video.toJson();
//    }
//    if (this.gallery != null) {
//      data['gallery'] = this.gallery.toJson();
//    }
//    if (this.writer != null) {
//      data['writer'] = this.writer.toJson();
//    }
//    data['tagNames'] = this.tagNames;
    data['id'] = this.id;
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

class Video {
  String description;
  int duration;
  String url;

  Video({this.description, this.duration, this.url});

  Video.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    duration = json['duration'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['url'] = this.url;
    return data;
  }
}

class Gallery {
  List<PhotoCollection> photoCollection;
  int photoCollectionCount;

  Gallery({this.photoCollection, this.photoCollectionCount});

  Gallery.fromJson(Map<String, dynamic> json) {
    if (json['photoCollection'] != null) {
      photoCollection = new List<PhotoCollection>();
      json['photoCollection'].forEach((v) {
        photoCollection.add(new PhotoCollection.fromJson(v));
      });
    }
    photoCollectionCount = json['photoCollectionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photoCollection != null) {
      data['photoCollection'] =
          this.photoCollection.map((v) => v.toJson()).toList();
    }
    data['photoCollectionCount'] = this.photoCollectionCount;
    return data;
  }
}

class PhotoCollection {
  String url;
  String description;

  PhotoCollection({this.url, this.description});

  PhotoCollection.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['description'] = this.description;
    return data;
  }
}

class Writer {
  String tenantId;
  String userName;
  String email;
  bool emailConfirmed;
  String phoneNumber;
  bool phoneNumberConfirmed;
  String id;

  Writer(
      {this.tenantId,
        this.userName,
        this.email,
        this.emailConfirmed,
        this.phoneNumber,
        this.phoneNumberConfirmed,
        this.id});

  Writer.fromJson(Map<String, dynamic> json) {
    tenantId = json['tenantId'];
    userName = json['userName'];
    email = json['email'];
    emailConfirmed = json['emailConfirmed'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenantId'] = this.tenantId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['emailConfirmed'] = this.emailConfirmed;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['id'] = this.id;
    return data;
  }
}