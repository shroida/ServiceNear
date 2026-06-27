import 'package:mockito/annotations.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';
import 'package:servicenear/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:servicenear/common/core/repositories/user_repository.dart';

@GenerateMocks([
  AuthRepository,
  AuthRemoteDataSource,
  UserRepository,
])
void main() {}