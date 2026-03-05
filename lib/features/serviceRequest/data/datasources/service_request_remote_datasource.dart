import 'package:supabase_flutter/supabase_flutter.dart';

class ServiceRequestRemoteDataSource {
  final SupabaseClient client;

  ServiceRequestRemoteDataSource(this.client);

  Future<void> createRequest(Map<String, dynamic> data) async {
    await client.from('service_requests').insert(data);
  }
}
