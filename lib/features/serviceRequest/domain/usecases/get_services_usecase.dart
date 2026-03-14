import 'package:servicenear/features/serviceRequest/domain/entities/service.dart';
import 'package:servicenear/features/serviceRequest/domain/repositories/service_repository.dart';

class GetServicesUsecase {
  final ServiceRepository repository;

  GetServicesUsecase(this.repository);

  Future<List<Service>> call(String specialty) {
    print("[UseCase] call called with specialty: $specialty");
    return repository.getServices(specialty: specialty);
  }
}
