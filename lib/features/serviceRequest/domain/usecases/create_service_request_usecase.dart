import '../entities/service_request.dart';
import '../repositories/service_request_repository.dart';

class CreateServiceRequestUseCase {
  final ServiceRequestRepository repository;

  CreateServiceRequestUseCase(this.repository);

  Future<void> call(ServiceRequest request) {
    return repository.createRequest(request);
  }
}
