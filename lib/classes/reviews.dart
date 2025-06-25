class Reviews {
  int? id;
  String review;

  Reviews({this.id, required this.review});

  factory Reviews.fromMap(Map<String, dynamic> map) {
    return Reviews(id: map['id'] as int?, review: map['review'] as String);
  }

  Map<String, dynamic> toMap() {
    return {'review': review};
  }
}
