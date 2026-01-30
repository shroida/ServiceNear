import 'app_user.dart';

class WorkerUser extends AppUserAuth {
  final String specialty;

  WorkerUser({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    required this.specialty,
  });
}
