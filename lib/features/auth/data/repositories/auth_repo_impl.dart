import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/common/core/repositories/user_repository.dart';
import 'package:servicenear/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final UserRepository userRepository;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.userRepository,
  });

  @override
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
    String? address,
    String? about,
  }) async {
    final userId = await remoteDataSource.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      userType: userType.nameStr,
      latitude: latitude,
      longitude: longitude,
      specialty: specialty,
      phone: phone,
      address: address,
      about: about,
    );

    final user = await userRepository.getUserById(userId);
    if (user == null) {
      throw Exception("User profile not found after registration");
    }
    return user;
  }

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    final userId = await remoteDataSource.signIn(
      email: email,
      password: password,
    );
    final user = await userRepository.getUserById(userId);
    if (user == null) throw Exception("User profile not found after login");
    return user;
  }

  @override
  Future<void> logout() => remoteDataSource.signOut();
}
