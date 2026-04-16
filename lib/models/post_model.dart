class PostModel {
  final dynamic userId;
  final dynamic id;
  final String title;
  final String body;

  PostModel({this.userId, this.id, required this.title, required this.body});

  factory PostModel.fromJson(Map<String, dynamic> jsonData) {
    return PostModel(
      userId: jsonData["userId"],
      id: jsonData["id"],
      title: jsonData["title"] ?? "",
      body: jsonData["body"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }
}
