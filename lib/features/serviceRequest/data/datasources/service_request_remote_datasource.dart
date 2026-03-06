import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';

abstract class ServiceRequestRemoteDataSource {
  Future<List<ServiceRequest>> getWorkerRequests(String workerId);
  Future<void> createRequest(Map<String, dynamic> data);
  Future<void> updateRequestStatus(String requestId, String status);
}
