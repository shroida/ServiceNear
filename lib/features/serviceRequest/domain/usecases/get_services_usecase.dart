import 'package:servicenear/features/serviceRequest/domain/repositories/service_repository.dart';

class GetServicesUsecase {
  final ServiceRepository repository;

  GetServicesUsecase(this.repository);

  Future<void> call(String specialty) {
    return repository.getServices(specialty: specialty);
  }
}
