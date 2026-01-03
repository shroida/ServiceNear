import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_type.dart';
import '../../domain/entities/user_location.dart';

class AppUserModel extends AppUser {
  final String? specialty; 

  AppUserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    this.specialty,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      userType: UserTypeExtension.fromString(json['user_type']),
      location: UserLocation.fromJson(json),
      createdAt: DateTime.parse(json['created_at']),
      specialty: json['specialty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'user_type': userType.nameStr,
      ...location.toJson(),
      if (specialty != null) 'specialty': specialty,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
