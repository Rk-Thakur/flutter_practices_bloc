class UserModel {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  UserModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl'],
        url: json['url']);
  }

  Object? toJson() {
    return null;
  }
}
