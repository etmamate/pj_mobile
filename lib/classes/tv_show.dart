class TvShow {
  final int id;
  final String name;
  final String? posterPath;
  final String? overview;
  final DateTime? lastUpdated;
  final DateTime? firstAirDate;
  final String? backdropPath; // Novo campo para o banner

  TvShow({
    required this.id,
    required this.name,
    this.posterPath,
    this.overview,
    this.lastUpdated,
    this.firstAirDate,
    this.backdropPath,
  });

  factory TvShow.fromMap(Map<String, dynamic> map) {
    return TvShow(
      id: map['id'] as int,
      name: map['name'] as String,
      posterPath: map['poster_path'] as String?,
      overview: map['overview'] as String?,
      lastUpdated:
          map['last_updated'] != null
              ? DateTime.parse(map['last_updated'] as String)
              : null,
      firstAirDate:
          map['first_air_date'] != null
              ? DateTime.parse(map['first_air_date'] as String)
              : null,
      backdropPath: map['backdrop_path'] as String?, // Adicionado
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'poster_path': posterPath,
      'overview': overview,
      'last_updated': lastUpdated?.toIso8601String(),
      'first_air_date': firstAirDate?.toIso8601String(),
      'backdrop_path': backdropPath, // Adicionado
    };
  }
}
