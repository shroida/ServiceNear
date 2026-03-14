import 'package:servicenear/features/serviceRequest/domain/entities/service.dart';

abstract class ServiceRepository {
  Future<List<Service>> getServices({String? specialty});
}
