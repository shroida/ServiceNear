import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_type.dart';

abstract class AuthRepository {
  Future<AppUser> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required UserType userType,
    required double latitude,
    required double longitude,
    String? specialty,
    String? phone,
  });
  Future<AppUser> login({required String email, required String password});
}
