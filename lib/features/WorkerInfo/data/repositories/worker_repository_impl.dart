import 'package:servicenear/common/entities/worker.dart';
import 'package:servicenear/features/WorkerInfo/data/datasources/rating_remote_datasource.dart';
import 'package:servicenear/features/WorkerInfo/data/models/rating_model.dart';
import 'package:servicenear/features/WorkerInfo/domain/entities/rating_entity.dart';
import 'package:servicenear/features/WorkerInfo/domain/repositories/worker_repository.dart';

class WorkerRepositoryImpl implements WorkerRepository {
  final RatingRemoteDataSource remoteDataSource;

  WorkerRepositoryImpl(this.remoteDataSource);
  @override
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

  @override
  Future<Worker> addAbout(String workerId, String about) {
    throw UnimplementedError();
  }
}
