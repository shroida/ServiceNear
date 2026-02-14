import 'package:servicenear/common/entities/worker.dart';

abstract class HomeRepository {
  Future<List<Worker>> getWorkers();
}
