import 'package:servicenear/features/WorkerInfo/domain/entities/rating_entity.dart';
import 'package:servicenear/features/WorkerInfo/domain/repositories/worker_repository.dart';

class FetchReviewsUseCase {
  final WorkerRepository repository;

  FetchReviewsUseCase(this.repository);

  Future<List<RatingEntity>> call(String workerId) async {
    return await repository.fetchReviews(workerId);
  }
}
