import 'app_user_auth.dart';

class CustomerUser extends AppUserAuth {
  CustomerUser({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
  });
}
