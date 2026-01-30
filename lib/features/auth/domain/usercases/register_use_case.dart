import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_type.dart';

import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<AppUser> call({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required UserType userType,
    required double latitude,
    required double longitude,
    String? specialty,
  }) {
    return repository.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      userType: userType,
      latitude: latitude,
      longitude: longitude,
      specialty: specialty,
    );
  }
}
