import 'app_user.dart';
import 'user_type.dart';

class WorkerUser extends AppUser {
  final String specialty;

  const WorkerUser({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.location,
    required super.createdAt,
    required this.specialty,
  }) : super(userType: UserType.worker);
}
