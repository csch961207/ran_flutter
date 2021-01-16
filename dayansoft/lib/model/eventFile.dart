class EventFile {
  int eventId;
  String filename;
  String filePath;
  double photoshootpositionLng;
  double photoshootpositionLat;
  int isUpload;

  EventFile(
      {this.eventId,
      this.filename,
      this.filePath,
      this.photoshootpositionLng,
      this.photoshootpositionLat,
      this.isUpload
      });

  EventFile.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    filename = json['filename'];
    filePath = json['filePath'];
    photoshootpositionLng = json['photoshootpositionLng'];
    photoshootpositionLat = json['photoshootpositionLat'];
    isUpload = json['isUpload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['filename'] = this.filename;
    data['filePath'] = this.filePath;
    data['photoshootpositionLng'] = this.photoshootpositionLng;
    data['photoshootpositionLat'] = this.photoshootpositionLat;
    data['isUpload'] = this.isUpload;
    return data;
  }
}
