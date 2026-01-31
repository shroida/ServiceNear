import 'package:servicenear/common/entities/app_user.dart';

class WorkerUserHomeModel extends AppUser {
  final String? specialty;

  WorkerUserHomeModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNubmer,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    this.specialty,
  });
}
