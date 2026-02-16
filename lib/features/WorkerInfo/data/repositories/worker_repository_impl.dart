import 'package:servicenear/features/WorkerInfo/data/datasources/rating_remote_datasource.dart';
import 'package:servicenear/features/WorkerInfo/data/models/rating_model.dart';
import 'package:servicenear/features/WorkerInfo/domain/entities/rating_entity.dart';

abstract class WorkerRepositoryImpl {
  final RatingRemoteDataSource remoteDataSource;

  WorkerRepositoryImpl(this.remoteDataSource);

  Future<void> submitRating(RatingEntity rating) async {
    final model = RatingModel(
      workerId: rating.workerId,
      customerId: rating.customerId,
      rating: rating.rating,
      review: rating.review,
      createdAt: rating.createdAt,
      ratingrId: rating.ratingrId,
    );

    await remoteDataSource.submitRating(model);
  }
}
