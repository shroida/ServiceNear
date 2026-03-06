import 'package:servicenear/features/serviceRequest/domain/repositories/service_request_repository.dart';

class UpdateRequestStatus {
  final ServiceRequestRepository repository;

  UpdateRequestStatus(this.repository);
  Future<void> call(String requestId, String newStatus) async {
    await repository.updateRequestStatus(requestId, newStatus);
  }
}
