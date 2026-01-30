import 'package:servicenear/features/home/domain/entities/worker_user_home_model.dart';
import 'package:servicenear/features/home/domain/repositories/home_repositories.dart';

class GetWorkersUseCase {
  final HomeRepository repository;

  GetWorkersUseCase(this.repository);

  Future<List<WorkerUserHomeModel>> call() {
    return repository.getWorkers();
  }
}
