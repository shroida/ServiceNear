import '../entities/service_request.dart';
import '../repositories/service_request_repository.dart';

class GetBookedServicesUseCase {
  final ServiceRequestRepository repository;

  GetBookedServicesUseCase(this.repository);

  Future<List<ServiceRequest>> call(String customerId) async {
    return repository.getCustomerRequests(customerId);
  }
}
