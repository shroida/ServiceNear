import 'app_user_auth.dart';

class WorkerAuthUser extends AppUserAuth {
  final String specialty;
  final String address;
  final String about;

  WorkerAuthUser({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    required this.specialty,
    required this.address,
    required this.about,
  });
}
