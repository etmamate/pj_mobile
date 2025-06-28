class Reviews {
  int? id;
  String review;
  int? tvShowId;
  DateTime? createdAt;

  Reviews({this.id, required this.review, this.tvShowId, this.createdAt});

  factory Reviews.fromMap(Map<String, dynamic> map) {
    return Reviews(
      id: map['id'] as int?,
      review: map['review'] as String,
      tvShowId: map['tv_show_id'] as int?,
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'] as String)
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'review': review,
      'tv_show_id': tvShowId,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
