import '../repositories/service_request_repository.dart';

class GetServices {
  final ServiceRequestRepository repository;

  GetServices(this.repository);

  Future<void> call(String specialty) {
    return repository.getServices(specialty: specialty);
  }
}
