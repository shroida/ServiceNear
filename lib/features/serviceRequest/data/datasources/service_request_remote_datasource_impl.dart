import 'package:servicenear/features/serviceRequest/data/models/service_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/service_request.dart';
import '../models/service_request_model.dart';
import 'service_request_remote_datasource.dart';

class ServiceRequestRemoteDataSourceImpl
    implements ServiceRequestRemoteDataSource {
  final SupabaseClient client;

  ServiceRequestRemoteDataSourceImpl(this.client);

  @override
  Future<void> createRequest(Map<String, dynamic> data) async {
    await client.from('service_requests').insert(data);
  }

  @override
  Future<List<ServiceRequest>> getWorkerRequests(String workerId) async {
    final res = await client
        .from('service_requests')
        .select()
        .eq('worker_id', workerId);

    return res
        .map<ServiceRequest>((e) => ServiceRequestModel.fromMap(e))
        .toList();
  }

  @override
  Future<void> updateRequestStatus(String requestId, String status) async {
    await client
        .from('service_requests')
        .update({'status': status})
        .eq('id', requestId);
  }

  @override
  Future<List<ServiceModel>> getServices({String? specialty}) async {
    print(
      "[Remote] fetching services from Supabase with specialty: $specialty",
    );
    final query = client.from('services').select();
    if (specialty != null) query.eq('specialty', specialty);

    final res = await query;
    print("[Remote] raw response: $res");

    final list = (res as List).map((e) => ServiceModel.fromMap(e)).toList();
    print("[Remote] mapped ${list.length} services");
    return list;
  }
}
