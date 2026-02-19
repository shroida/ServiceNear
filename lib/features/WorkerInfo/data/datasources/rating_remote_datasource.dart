import 'package:servicenear/features/WorkerInfo/data/models/rating_model.dart';

abstract class RatingRemoteDataSource {
  Future<void> submitRating(RatingModel rating);
  Future<List<RatingModel>> fetchReviews(String workerId);
}
