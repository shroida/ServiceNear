import 'package:servicenear/features/auth/data/models/user_location.dart';
import 'package:servicenear/features/auth/presentation/widgets/models/user_type.dart';

class AppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final UserType role;
  final UserLocation location;
  final DateTime createdAt;

  const AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.location,
    required this.createdAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      role: json['role'] == 'worker' ? UserType.worker : UserType.customer,
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
      'role': role.name,
      ...location.toJson(), // 🔥 merge location fields
      'created_at': createdAt.toIso8601String(),
    };
  }
}
