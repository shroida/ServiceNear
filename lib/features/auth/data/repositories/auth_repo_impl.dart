import 'package:servicenear/features/auth/domain/entities/app_user.dart';
import 'package:servicenear/features/auth/domain/entities/customer_user.dart';
import 'package:servicenear/features/auth/domain/entities/user_location.dart';
import 'package:servicenear/features/auth/domain/entities/user_type.dart';
import 'package:servicenear/features/auth/domain/entities/worker_user.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

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
  }) async {
    final response = await remoteDataSource.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      userType: userType.nameStr,
      latitude: latitude,
      longitude: longitude,
      specialty: specialty,
    );

    // Map the response JSON to Domain entity
    if (userType == UserType.customer) {
      return CustomerUser(
        id: response['id'],
        firstName: firstName,
        lastName: lastName,
        email: email,
        location: UserLocation(latitude: latitude, longitude: longitude),
        createdAt: DateTime.parse(response['created_at']),
      );
    } else {
      return WorkerUser(
        id: response['id'],
        firstName: firstName,
        lastName: lastName,
        email: email,
        location: UserLocation(latitude: latitude, longitude: longitude),
        createdAt: DateTime.parse(response['created_at']),
        specialty: specialty!,
      );
    }
  }
}
