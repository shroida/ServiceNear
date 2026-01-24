import 'package:servicenear/features/auth/data/models/customer_user_model.dart';
import 'package:servicenear/features/auth/data/models/worker_user_model.dart';
import 'package:servicenear/features/auth/domain/entities/app_user.dart';
import 'package:servicenear/features/auth/domain/entities/user_location.dart';
import 'package:servicenear/features/auth/domain/entities/user_type.dart';
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
    String? phone,
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
      phone: phone,
    );

    if (userType == UserType.customer) {
      return CustomerUserModel(
        id: response['id'],
        userType: userType,
        firstName: firstName,
        lastName: lastName,
        email: email,
        location: UserLocation(latitude: latitude, longitude: longitude),
        createdAt: DateTime.parse(response['created_at']),
      );
    } else {
      return WorkerUserModel(
        id: response['id'],
        firstName: firstName,
        userType: userType,
        lastName: lastName,
        email: email,
        location: UserLocation(latitude: latitude, longitude: longitude),
        createdAt: DateTime.parse(response['created_at']),
        specialty: specialty!,
      );
    }
  }

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    final response = await remoteDataSource.signIn(
      email: email,
      password: password,
    );

    final userType = UserTypeExtension.fromString(response['user_type']);

    if (userType == UserType.customer) {
      return CustomerUserModel(
        id: response['id'],
        userType: userType,
        firstName: response['first_name'],
        lastName: response['last_name'],
        email: response['email'],
        location: UserLocation(
          latitude: response['latitude'],
          longitude: response['longitude'],
        ),
        createdAt: DateTime.parse(response['created_at']),
      );
    } else {
      return WorkerUserModel(
        id: response['id'],
        userType: userType,
        firstName: response['first_name'],
        lastName: response['last_name'],
        email: response['email'],
        location: UserLocation(
          latitude: response['latitude'],
          longitude: response['longitude'],
        ),
        createdAt: DateTime.parse(response['created_at']),
        specialty: response['specialty'],
      );
    }
  }
}
