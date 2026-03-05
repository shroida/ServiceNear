import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/service_request.dart';
import '../../domain/repositories/service_request_repository.dart';
import '../models/service_request_model.dart';
import '../datasources/service_request_remote_datasource.dart';

class ServiceRequestRepositoryImpl implements ServiceRequestRepository {
  final SupabaseClient client;
  final ServiceRequestRemoteDataSource remoteDataSource;

  ServiceRequestRepositoryImpl(this.client, this.remoteDataSource);

  @override
  Future<void> createRequest(ServiceRequest request) async {
    final model = request as ServiceRequestModel;

    await remoteDataSource.createRequest(model.toMap());
  }

  @override
  Future<List<ServiceRequest>> getWorkerRequests(int workerId) async {
    return remoteDataSource.getWorkerRequests(workerId);
  }

  @override
  Future<List<ServiceRequest>> getCustomerRequests(int customerId) async {
    return remoteDataSource.getCustomerRequests(customerId);
  }

  @override
  Future<void> updateRequestStatus(String requestId, String status) async {
    return remoteDataSource.updateRequestStatus(requestId, status);
  }
}
