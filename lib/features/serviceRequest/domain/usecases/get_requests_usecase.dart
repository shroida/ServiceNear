import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';
import 'package:servicenear/features/serviceRequest/domain/repositories/service_request_repository.dart';

class GetRequestsUseCase {
  final ServiceRequestRepository repository;

  GetRequestsUseCase(this.repository);

  Future<List<ServiceRequest>> call(String customerId) async {
    return await repository.getCustomerRequests(customerId);
  }
}
