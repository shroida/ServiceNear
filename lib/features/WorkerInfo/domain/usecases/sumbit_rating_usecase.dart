import 'package:servicenear/features/WorkerInfo/domain/repositories/worker_repository.dart';

import '../entities/rating_entity.dart';

class SubmitRatingUseCase {
  final WorkerRepository repository;

  SubmitRatingUseCase(this.repository);

  Future<void> call(RatingEntity rating) {
    return repository.submitRating(rating);
  }
}
