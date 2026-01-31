import '../../domain/entities/worker_user_home_model.dart';
import '../../domain/repositories/home_repositories.dart';
import '../datasource/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<WorkerUserHomeModel>> getWorkers() async {
    final models = await remoteDataSource.getWorkers();

    return models
        .map(
          (m) => WorkerUserHomeModel(
            id: m.id,
            firstName: m.firstName,
            lastName: m.lastName,
            email: m.email,
            phoneNubmer: m.phoneNubmer,
            userType: m.userType,
            location: m.location,
            createdAt: m.createdAt,
            specialty: m.specialty,
          ),
        )
        .toList();
  }
}
