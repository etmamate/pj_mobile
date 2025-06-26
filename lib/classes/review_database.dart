import 'package:pj_mobile/classes/reviews.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewDatabase {
  final database = Supabase.instance.client.from('reviews');
  final tvShowsTable = Supabase.instance.client.from('tv_shows');

  Future<void> createReview(Reviews newReview) async {
    try {
      await database.insert(newReview.toMap());
    } catch (e) {
      print('Erro ao criar review: $e');
      rethrow;
    }
  }

  final stream = Supabase.instance.client
      .from("reviews")
      .stream(primaryKey: ['id'])
      .map((data) => data.map((reviewMap) => Reviews.fromMap(reviewMap)).toList());

  Future<void> updateReview(Reviews oldReviews, String newReview) async {
    await database.update({'review': newReview, 'tv_show_id': oldReviews.tvShowId}).eq('id', oldReviews.id!);
  }

  Future<void> deleteReview(Reviews review) async {
    await database.delete().eq('id', review.id!);
  }

  Future<void> cacheTvShow(int id, String name, String? posterPath, String? overview) async {
    await tvShowsTable.upsert({
      'id': id,
      'name': name,
      'poster_path': posterPath,
      'overview': overview,
      'last_updated': DateTime.now().toIso8601String(),
    });
  }

  // Novo método para buscar reviews por tv_show_id
  Future<List<Reviews>> getReviewsByTvShowId(int tvShowId) async {
    try {
      final response = await database.select().eq('tv_show_id', tvShowId);
      return (response as List).map((map) => Reviews.fromMap(map)).toList();
    } catch (e) {
      print('Erro ao buscar reviews: $e');
      return [];
    }
  }
}