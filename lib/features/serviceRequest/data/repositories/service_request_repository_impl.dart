import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/service_request.dart';
import '../../domain/repositories/service_request_repository.dart';
import '../models/service_request_model.dart';

class ServiceRequestRepositoryImpl implements ServiceRequestRepository {
  final SupabaseClient client;

  ServiceRequestRepositoryImpl(this.client);

  @override
  Future<void> createRequest(ServiceRequest request) async {
    final model = request as ServiceRequestModel;

    await client.from('service_requests').insert(model.toMap());
  }

  @override
  Future<List<ServiceRequest>> getWorkerRequests(int workerId) async {
    final res = await client
        .from('service_requests')
        .select()
        .eq('worker_id', workerId);

    return res.map<ServiceRequest>((e) {
      return ServiceRequestModel.fromMap(e);
    }).toList();
  }

  @override
  Future<List<ServiceRequest>> getCustomerRequests(int customerId) async {
    final res = await client
        .from('service_requests')
        .select()
        .eq('customer_id', customerId);

    return res.map<ServiceRequest>((e) {
      return ServiceRequestModel.fromMap(e);
    }).toList();
  }

  @override
  Future<void> updateRequestStatus(String requestId, String status) async {
    await client
        .from('service_requests')
        .update({'status': status})
        .eq('id', requestId);
  }
}
