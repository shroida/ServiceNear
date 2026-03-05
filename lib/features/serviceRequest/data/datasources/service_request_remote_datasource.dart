import 'package:servicenear/features/serviceRequest/data/models/service_request_model.dart';
import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServiceRequestRemoteDataSource {
  final SupabaseClient client;

  ServiceRequestRemoteDataSource(this.client);

  Future<void> createRequest(Map<String, dynamic> data) async {
    await client.from('service_requests').insert(data);
  }

  Future<List<ServiceRequest>> getWorkerRequests(String workerId) async {
    final res = await client
        .from('service_requests')
        .select()
        .eq('worker_id', workerId);

    return res.map<ServiceRequest>((e) {
      return ServiceRequestModel.fromMap(e);
    }).toList();
  }

  Future<List<ServiceRequest>> getCustomerRequests(String customerId) async {
    final res = await client
        .from('service_requests')
        .select()
        .eq('customer_id', customerId);

    return res.map<ServiceRequest>((e) {
      return ServiceRequestModel.fromMap(e);
    }).toList();
  }

  Future<void> updateRequestStatus(String requestId, String status) async {
    await client
        .from('service_requests')
        .update({'status': status})
        .eq('id', requestId);
  }
}
