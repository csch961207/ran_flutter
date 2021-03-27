class CommentsEntity {
  int totalCount;
  List<CommentsItem> items;

  CommentsEntity({this.totalCount, this.items});

  CommentsEntity.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = new List<CommentsItem>();
      json['items'].forEach((v) {
        items.add(new CommentsItem.fromJson(v));
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

class CommentsItem {
  String repliedCommentId;
  String text;
  Writer writer;
  bool isDeleted;
  String deleterId;
  String deletionTime;
  String lastModificationTime;
  String lastModifierId;
  String creationTime;
  String creatorId;
  String id;

  CommentsItem(
      {this.repliedCommentId,
        this.text,
        this.writer,
        this.isDeleted,
        this.deleterId,
        this.deletionTime,
        this.lastModificationTime,
        this.lastModifierId,
        this.creationTime,
        this.creatorId,
        this.id});

  CommentsItem.fromJson(Map<String, dynamic> json) {
    repliedCommentId = json['repliedCommentId'];
    text = json['text'];
    writer =
    json['writer'] != null ? new Writer.fromJson(json['writer']) : null;
    isDeleted = json['isDeleted'];
    deleterId = json['deleterId'];
    deletionTime = json['deletionTime'];
    lastModificationTime = json['lastModificationTime'];
    lastModifierId = json['lastModifierId'];
    creationTime = json['creationTime'];
    creatorId = json['creatorId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['repliedCommentId'] = this.repliedCommentId;
    data['text'] = this.text;
    if (this.writer != null) {
      data['writer'] = this.writer.toJson();
    }
    data['isDeleted'] = this.isDeleted;
    data['deleterId'] = this.deleterId;
    data['deletionTime'] = this.deletionTime;
    data['lastModificationTime'] = this.lastModificationTime;
    data['lastModifierId'] = this.lastModifierId;
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['id'] = this.id;
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