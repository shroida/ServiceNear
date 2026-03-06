import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';

abstract class ServiceRequestRemoteDataSource {
  Future<List<ServiceRequest>> getWorkerRequests(String workerId);
  Future<List<ServiceRequest>> getCustomerRequests(String customerId);
  Future<void> createRequest(Map<String, dynamic> data);
  Future<void> updateRequestStatus(String requestId, String status);
}
