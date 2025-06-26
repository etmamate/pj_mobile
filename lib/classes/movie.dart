class Movie {
  final int id;
  final String title;
  final String? posterPath;

  Movie({required this.id, required this.title, this.posterPath});

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] as String,
      posterPath: map['poster_path'] as String,
    );
  }
}
