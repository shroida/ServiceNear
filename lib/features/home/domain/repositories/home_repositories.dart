import '../entities/worker_user_home_model.dart';

abstract class HomeRepository {
  Future<List<WorkerUserHomeModel>> getWorkers();
}
