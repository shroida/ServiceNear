import '../entities/worker_info.dart';

abstract class WorkerRepository {
  Future<WorkerInfo> addAbout(String workerId, String about);
}
