// domain/usecases/get_workers_usecase.dart
import 'package:servicenear/features/auth/data/models/worker_user_model.dart';
import 'package:servicenear/features/home/domain/repositories/home_repositories.dart';

class GetWorkersUseCase {
  final HomeRepository repository;

  GetWorkersUseCase(this.repository);

  Future<List<WorkerUserModel>> call() {
    return repository.getWorkers();
  }
}
