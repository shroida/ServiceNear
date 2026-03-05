import '../entities/service_request.dart';

abstract class ServiceRequestRepository {
  Future<void> createRequest(ServiceRequest request);

  Future<List<ServiceRequest>> getWorkerRequests(int workerId);

  Future<List<ServiceRequest>> getCustomerRequests(int customerId);

  Future<void> updateRequestStatus(String requestId, String status);
}
