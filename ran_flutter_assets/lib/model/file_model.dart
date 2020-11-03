class Files {
  int totalCount;
  List<FileItem> items;

  Files({this.totalCount, this.items});

  Files.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = new List<FileItem>();
      json['items'].forEach((v) {
        items.add(new FileItem.fromJson(v));
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

class FileItem {
  String providerKey;
  String folderId;
  String name;
  int size;
  String webUrl;
  String creationTime;
  String creatorId;
  String id;

  FileItem(
      {this.providerKey,
        this.folderId,
        this.name,
        this.size,
        this.webUrl,
        this.creationTime,
        this.creatorId,
        this.id});

  FileItem.fromJson(Map<String, dynamic> json) {
    providerKey = json['providerKey'];
    folderId = json['folderId'];
    name = json['name'];
    size = json['size'];
    webUrl = json['webUrl'];
    creationTime = json['creationTime'];
    creatorId = json['creatorId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['providerKey'] = this.providerKey;
    data['folderId'] = this.folderId;
    data['name'] = this.name;
    data['size'] = this.size;
    data['webUrl'] = this.webUrl;
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['id'] = this.id;
    return data;
  }
}