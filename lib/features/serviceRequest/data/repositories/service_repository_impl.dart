import 'package:servicenear/features/serviceRequest/data/datasources/service_request_remote_datasource.dart';
import 'package:servicenear/features/serviceRequest/domain/entities/service.dart';
import 'package:servicenear/features/serviceRequest/domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRequestRemoteDataSource remoteDataSource;

  ServiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Service>> getServices({String? specialty}) async {
    final serviceModels = await remoteDataSource.getServices(
      specialty: specialty,
    );
    return serviceModels.map((model) => model.toEntity()).toList();
  }
}
