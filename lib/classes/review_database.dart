import 'package:pj_mobile/classes/reviews.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewDatabase {
  // Database = > reviews
  final database = Supabase.instance.client.from('reviews');

  // Create

  Future createReview(Reviews newReview) async {
    await database.insert(newReview.toMap());
  }

  // Read

  final stream = Supabase.instance.client
      .from("reviews")
      .stream(primaryKey: ['id'])
      .map(
        (data) => data.map((reviewMap) => Reviews.fromMap(reviewMap)).toList(),
      );

  // Update

  Future updateReview(Reviews oldReviews, String newReview) async {
    await database.update({'content': newReview}).eq('id', oldReviews.id!);
  }

  // Delete
  Future deleteReview(Reviews review) async {
    await database.delete().eq('id', review.id!);
  }
}
