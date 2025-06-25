
class Reviews {
  int? id;
  String content;

  Reviews({this.id, required this.content});

  factory Reviews.fromMap(Map<String, dynamic> map) {
    return Reviews(id: map['id'] as int, content: map['content'] as String);
  }

  Map<String, dynamic> toMap() {
    return {content: 'content'};
  }
}
