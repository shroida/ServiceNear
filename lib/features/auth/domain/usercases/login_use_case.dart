// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:servicenear/features/auth/domain/entities/app_user.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase(
    this.authRepository,
  );
  Future<AppUser> call(
    String email,
    String password,
  ) async {
    return authRepository.login(email: email, password: password);
  }
}
