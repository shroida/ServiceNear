import 'package:servicenear/common/entities/worker.dart';
import 'package:servicenear/features/home/domain/repositories/home_repositories.dart';

class GetWorkersUseCase {
  final HomeRepository repository;

  GetWorkersUseCase(this.repository);

  Future<List<Worker>> call() {
    return repository.getWorkers();
  }
}
