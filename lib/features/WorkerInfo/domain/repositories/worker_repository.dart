import 'package:servicenear/common/entities/worker.dart';

abstract class WorkerRepository {
  Future<Worker> addAbout(String workerId, String about);
}
