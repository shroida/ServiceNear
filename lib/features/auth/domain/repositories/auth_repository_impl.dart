import 'package:servicenear/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:servicenear/features/auth/domain/entities/app_user.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  Future<void> login(String email, String password) {
    return remoteDataSource.signIn(
      email: email,
      password: password,
    );
  }

  @override
  Future<AppUser> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String userType,
      required double latitude,
      required double longitude,
      String? specialty}) {
    throw UnimplementedError();
  }
}
