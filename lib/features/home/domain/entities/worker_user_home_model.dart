import 'package:servicenear/features/home/domain/entities/app_user_home.dart';

class WorkerUserHomeModel extends AppUserHome {
  WorkerUserHomeModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
  });
}
