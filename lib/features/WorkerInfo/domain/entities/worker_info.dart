import 'package:servicenear/common/entities/worker.dart';

class WorkerInfo extends Worker {
  const WorkerInfo({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNubmer,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    required super.rating,
    required super.reviewsCount,
    required super.about,
    required super.address,
  });
}
