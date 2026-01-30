import 'package:servicenear/features/auth/data/models/worker_user_model.dart';
import 'package:servicenear/features/auth/domain/entities/user_location.dart';
import 'package:servicenear/features/auth/domain/entities/user_type.dart';

class WorkerModel extends WorkerUserModel {
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
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      specialty: map['specialty'],
      userType: UserTypeExtension.fromString(map['user_type']),
      location: UserLocation.fromJson(map),
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
