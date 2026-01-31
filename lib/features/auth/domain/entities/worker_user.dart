import 'app_user_auth.dart';

class WorkerAuthUser extends AppUserAuth {
  final String specialty;

  WorkerAuthUser({
    required super.id,
    required super.firstName,
    required super.phoneNubmer,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    required this.specialty,
  });
}
