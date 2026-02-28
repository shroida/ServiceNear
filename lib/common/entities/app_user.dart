import 'user_type.dart';
import 'user_location.dart';

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
  factory AppUser.fromMap(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'] ?? '',
      userType: UserType.customer,
      location: UserLocation.fromJson(json['location'] ?? {}),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
