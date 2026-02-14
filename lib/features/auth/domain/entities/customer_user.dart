import 'app_user_auth.dart';

class CustomerAuthUser extends AppUserAuth {
  CustomerAuthUser({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
  });
}
