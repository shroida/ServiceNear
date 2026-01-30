import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import '../../domain/entities/worker_user_home_model.dart';

class WorkerModel extends WorkerUserHomeModel {
  WorkerModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    super.specialty,
  });

  factory WorkerModel.fromMap(Map<String, dynamic> map) {
    return WorkerModel(
      id: map['id']?.toString() ?? 'unknown-id',
      firstName: map['first_name'] ?? 'Unknown',
      lastName: map['last_name'] ?? 'Unknown',
      email: map['email'] ?? 'no-email@example.com',
      userType: UserTypeExtension.fromString(map['user_type'] ?? 'customer'),
      location: UserLocation.fromJson(map),
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      specialty: map['specialty'],
    );
  }
}
