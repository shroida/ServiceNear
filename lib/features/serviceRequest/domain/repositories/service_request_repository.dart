import '../entities/service_request.dart';

abstract class ServiceRequestRepository {
  Future<void> createRequest(ServiceRequest request);

  Future<List<ServiceRequest>> getWorkerRequests(String workerId);

  Future<void> updateRequestStatus(String requestId, String status);
  Future<List<ServiceRequest>> getCustomerRequests(String customerId);
}
