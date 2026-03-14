import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);
  Future<AppUser> call(String email, String password) async {
    return await authRepository.login(email: email, password: password);
  }
}
