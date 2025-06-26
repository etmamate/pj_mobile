import 'package:pj_mobile/classes/movie.dart';
import 'package:pj_mobile/core/api_client.dart';

class MovieService {
  Future<List<Movie>> getPopularMovies() async {
    try {
      final data = await ApiClient.get('/movie/popular');
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromMap(json)).toList();
    } catch (e) {
      print('Erro na API TMDb: $e');
      return []; // Retorna lista vazia em caso de erro
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final data = await ApiClient.get('/movie/$movieId');
      return Movie.fromMap(data);
    } catch (e) {
      print('Erro ao carregar detalhes do filme: $e');
      rethrow;
    }
  }
}
