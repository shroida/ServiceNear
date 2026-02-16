import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/rating_model.dart';
import 'rating_remote_datasource.dart';

class RatingRemoteDataSourceImpl implements RatingRemoteDataSource {
  final SupabaseClient client;

  RatingRemoteDataSourceImpl(this.client);

  @override
  Future<void> submitRating(RatingModel rating) async {
    await client.from("ratings").insert(rating.toMap());
  }
}
