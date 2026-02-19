import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/rating_model.dart';
import 'rating_remote_datasource.dart';

class RatingRemoteDataSourceImpl implements RatingRemoteDataSource {
  final SupabaseClient client;

  RatingRemoteDataSourceImpl(this.client);

  @override
  Future<void> submitRating(RatingModel rating) async {
    try {
      await client.from("ratings").insert({
        'worker_id': rating.workerId,
        'customer_id': rating.customerId,
        'rating': rating.rating,
        'review': rating.review,
        'created_at': DateTime.now().toIso8601String(),
      }).select();
    } catch (e) {
      SnackBar(content: Text("Error submitting rating: $e"));
      rethrow;
    }
  }

  @override
  Future<List<RatingModel>> fetchReviews(String workerId) async {
    final response = await client
        .from('ratings')
        .select()
        .eq('worker_id', workerId)
        .order('created_at', ascending: false);

    return (response as List).map((data) => RatingModel.fromMap(data)).toList();
  }
}
