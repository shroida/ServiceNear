import 'package:servicenear/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userType,
    required double latitude,
    required double longitude,
    String? specialty,
  });
}
