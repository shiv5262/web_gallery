class ImageModel {
  int? id;
  String? type;
  String? tags;
  String? previewURL;
  String? largeImageURL;
  String? webFormatURL;
  int? likes;
  int? comments;
  int? views;

  ImageModel({
    this.id,
    this.type,
    this.tags,
    this.previewURL,
    this.largeImageURL,
    this.webFormatURL,
    this.likes,
    this.comments,
    this.views,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    tags = json['tags'];
    previewURL = json['previewURL'];
    largeImageURL = json['largeImageURL'];
    likes = json['likes'];
    comments = json['comments'];
    views = json['views'];
  }
}
