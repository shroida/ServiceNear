import '../entities/service_request.dart';

abstract class ServiceRequestRepository {
  Future<void> createRequest(ServiceRequest request);

  Future<List<ServiceRequest>> getWorkerRequests(String workerId);

  Future<List<ServiceRequest>> getCustomerRequests(String customerId);

  Future<void> updateRequestStatus(String requestId, String status);
}
