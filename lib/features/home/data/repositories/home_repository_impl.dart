// data/repositories/home_repository_impl.dart
import 'package:servicenear/features/auth/data/models/worker_user_model.dart';
import 'package:servicenear/features/home/data/datasource/home_remote_datasource.dart';
import 'package:servicenear/features/home/domain/repositories/home_repositories.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<WorkerUserModel>> getWorkers() {
    return remoteDataSource.getWorkers();
  }
}
