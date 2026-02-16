import 'package:servicenear/features/WorkerInfo/data/models/rating_model.dart';

abstract class WorkerRepositoryImpl {
  Future<void> submitRating(RatingModel rating);
}
