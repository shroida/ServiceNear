import 'package:servicenear/features/auth/data/models/app_user_model.dart';
import 'package:servicenear/features/auth/domain/entities/user_type.dart';
import 'package:servicenear/features/auth/data/models/user_location.dart';

class WorkerUserModel extends AppUserModel {
  final String specialty;

  WorkerUserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    required this.specialty,
  });

  factory WorkerUserModel.fromJson(Map<String, dynamic> json) {
    return WorkerUserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      userType: UserType.worker,
      location: UserLocation.fromJson(json),
      createdAt: DateTime.parse(json['created_at']),
      specialty: json['specialty'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'specialty': specialty,
    };
  }
}
