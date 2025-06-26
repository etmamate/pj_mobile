import 'package:pj_mobile/classes/tv_show.dart';
import 'package:pj_mobile/core/api_client.dart';
import 'package:pj_mobile/classes/review_database.dart';

class TvShowService {
  final ReviewDatabase db = ReviewDatabase();

  Future<List<TvShow>> getPopularTvShows() async {
    try {
      final data = await ApiClient.get('/tv/popular?language=pt-BR&page=1');
      final List<dynamic> results = data['results'];
      final tvShows = results.map((json) => TvShow.fromMap(json)).toList();

      for (var tvShow in tvShows) {
        await db.cacheTvShow(
          tvShow.id,
          tvShow.name,
          tvShow.posterPath,
          tvShow.overview,
        );
      }

      return tvShows;
    } catch (e) {
      print('Erro na API TMDb: $e');
      return [];
    }
  }

  Future<TvShow> getTvShowDetails(int tvShowId) async {
    try {
      final data = await ApiClient.get('/tv/$tvShowId?language=pt-BR');
      final tvShow = TvShow.fromMap(data);
      await db.cacheTvShow(
        tvShow.id,
        tvShow.name,
        tvShow.posterPath,
        tvShow.overview,
      );
      return tvShow;
    } catch (e) {
      print('Erro ao carregar detalhes da série: $e');
      rethrow;
    }
  }
}
