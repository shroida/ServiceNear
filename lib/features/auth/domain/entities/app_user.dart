import 'package:servicenear/features/auth/data/models/user_location.dart';
import 'user_type.dart';

abstract class AppUser {
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
}
