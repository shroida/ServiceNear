import 'package:servicenear/features/home/domain/entities/worker_user_home_model.dart';

abstract class HomeRepository {
  Future<List<WorkerUserHomeModel>> getWorkers();
}
