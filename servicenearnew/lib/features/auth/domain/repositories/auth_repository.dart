import 'package:servicenearnew/features/auth/domain/entities/app_user.dart';
import 'package:servicenearnew/features/auth/domain/entities/user_type.dart';

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
  Future<void> login({required String email, required String password});
}
