import 'app_user.dart';
import 'user_type.dart';

class CustomerUser extends AppUser {
  const CustomerUser({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.location,
    required super.createdAt,
  }) : super(userType: UserType.customer);
}
