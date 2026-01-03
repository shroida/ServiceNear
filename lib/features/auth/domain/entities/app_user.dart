import 'package:servicenear/features/auth/data/models/user_location.dart';
import 'package:servicenear/features/auth/domain/entities/user_type.dart';

class AppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final UserType userType;
  final UserLocation location;
  final DateTime createdAt;

  const AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userType,
    required this.location,
    required this.createdAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      userType: json['user_type'] == 'worker' ? UserType.worker : UserType.customer,
      location: UserLocation.fromJson(json),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'user_type': userType.name,
      ...location.toJson(), // 🔥 merge location fields
      'created_at': createdAt.toIso8601String(),
    };
  }
}
