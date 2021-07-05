class Blobs {
  List<Items> items;

  Blobs({this.items});

  Blobs.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String id;
  String creationTime;
  String creatorId;
  String entityType;
  String entityId;
  String containerName;
  String blobName;
  int binarySize;
  String hash;

  Items(
      {this.id,
        this.creationTime,
        this.creatorId,
        this.entityType,
        this.entityId,
        this.containerName,
        this.blobName,
        this.binarySize,
        this.hash});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationTime = json['creationTime'];
    creatorId = json['creatorId'];
    entityType = json['entityType'];
    entityId = json['entityId'];
    containerName = json['containerName'];
    blobName = json['blobName'];
    binarySize = json['binarySize'];
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['entityType'] = this.entityType;
    data['entityId'] = this.entityId;
    data['containerName'] = this.containerName;
    data['blobName'] = this.blobName;
    data['binarySize'] = this.binarySize;
    data['hash'] = this.hash;
    return data;
  }
}