import 'package:servicenear/common/entities/worker.dart';
import 'package:servicenear/features/WorkerInfo/domain/entities/rating_entity.dart';

abstract class WorkerRepository {
  Future<Worker> addAbout(String workerId, String about);
  Future<void> submitRating(RatingEntity rating);
  Future<List<RatingEntity>> fetchReviews(String workerId);
}
