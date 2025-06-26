class Reviews {
  int? id;
  String review;
  int? movieId;

  Reviews({this.id, required this.review, this.movieId});

  factory Reviews.fromMap(Map<String, dynamic> map) {
    return Reviews(
      id: map['id'] as int?,
      review: map['review'] as String,
      movieId: map['movie_id'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'review': review, 'movieId': movieId};
  }
}
