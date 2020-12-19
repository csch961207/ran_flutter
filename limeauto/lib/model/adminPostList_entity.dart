import 'package:limeauto/model/blog_entity.dart';
import 'package:limeauto/model/postList_entity.dart';

class AdminPostList {
  int totalCount;
  List<AdminPostItem> items;

  AdminPostList({this.totalCount, this.items});

  AdminPostList.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = new List<AdminPostItem>();
      json['items'].forEach((v) {
        items.add(new AdminPostItem.fromJson(v));
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

class AdminPostItem {
  Blog blog;
  String postType;
//  List<String> coverImages;
//  String title;
  String auditedStatus;
  String publicationStatus;
  String publishTime;
  int readCount;
  int commentCount;
  int likeCount;
  int favoriteCount;
  bool isDeleted;
  String deleterId;
  String deletionTime;
  String lastModificationTime;
  String lastModifierId;
  String creationTime;
  String creatorId;
  String id;
  Media media;

  AdminPostItem(
      {this.blog,
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
        this.isDeleted,
        this.deleterId,
        this.deletionTime,
        this.lastModificationTime,
        this.lastModifierId,
        this.creationTime,
        this.creatorId,
        this.id});

  AdminPostItem.fromJson(Map<String, dynamic> json) {
    blog = json['blog'] != null ? new Blog.fromJson(json['blog']) : null;
    postType = json['postType'];
//    coverImages = json['coverImages'].cast<String>();
//    title = json['title'];
    auditedStatus = json['auditedStatus'];
    publicationStatus = json['publicationStatus'];
    publishTime = json['publishTime'];
    readCount = json['readCount'];
    commentCount = json['commentCount'];
    likeCount = json['likeCount'];
    favoriteCount = json['favoriteCount'];
    isDeleted = json['isDeleted'];
    deleterId = json['deleterId'];
    deletionTime = json['deletionTime'];
    lastModificationTime = json['lastModificationTime'];
    lastModifierId = json['lastModifierId'];
    creationTime = json['creationTime'];
    creatorId = json['creatorId'];
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
    data['postType'] = this.postType;
//    data['coverImages'] = this.coverImages;
//    data['title'] = this.title;
    data['auditedStatus'] = this.auditedStatus;
    data['publicationStatus'] = this.publicationStatus;
    data['publishTime'] = this.publishTime;
    data['readCount'] = this.readCount;
    data['commentCount'] = this.commentCount;
    data['likeCount'] = this.likeCount;
    data['favoriteCount'] = this.favoriteCount;
    data['isDeleted'] = this.isDeleted;
    data['deleterId'] = this.deleterId;
    data['deletionTime'] = this.deletionTime;
    data['lastModificationTime'] = this.lastModificationTime;
    data['lastModifierId'] = this.lastModifierId;
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['id'] = this.id;
    if (this.media != null) {
      data['media'] = this.media.toJson();
    }
    return data;
  }
}