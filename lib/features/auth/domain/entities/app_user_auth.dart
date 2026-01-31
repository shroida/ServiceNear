import 'package:servicenear/common/entities/app_user.dart';

class AppUserAuth extends AppUser {
  AppUserAuth({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNubmer,
    required super.userType,
    required super.location,
    required super.createdAt,
  });
}
