import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/common/models/app_user_model.dart';

class WorkerUserModel extends AppUserModel {
  WorkerUserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    super.specialty,
  });

  factory WorkerUserModel.fromJson(Map<String, dynamic> json) {
    return WorkerUserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      specialty: json['specialty'],
      userType: UserTypeExtension.fromString(json['user_type']),
      location: UserLocation.fromJson(json),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'user_type': userType.nameStr,
      ...location.toJson(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
