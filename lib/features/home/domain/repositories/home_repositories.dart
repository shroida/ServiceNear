// domain/repositories/home_repository.dart
import 'package:servicenear/features/auth/data/models/worker_user_model.dart';

abstract class HomeRepository {
  Future<List<WorkerUserModel>> getWorkers();
}
