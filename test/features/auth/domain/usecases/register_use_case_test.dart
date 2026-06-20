import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/features/auth/domain/usercases/register_use_case.dart';

import '../../../../helpers/mocks.mocks.dart';

void main() {
  late RegisterUseCase useCase;
  late MockAuthRepository repo;

  setUp(() {
    repo = MockAuthRepository();
    useCase = RegisterUseCase(repo);
  });

  test('should return AppUser when register is successful', () async {
    // arrange
    final user = AppUser(
      id: '1',
      email: 'test@test.com',
      location: UserLocation(latitude: 0.0, longitude: 0.0),
      userType: UserType.customer,
      createdAt: DateTime.now(),
      firstName: 'John',
      lastName: 'Doe',
    );

    when(repo.register(
      email: anyNamed('email'),
      password: anyNamed('password'),
      firstName: anyNamed('firstName'),
      lastName: anyNamed('lastName'),
      userType: anyNamed('userType'),
      latitude: anyNamed('latitude'),
      longitude: anyNamed('longitude'),
      address: anyNamed('address'),
      about: anyNamed('about'),
      specialty: anyNamed('specialty'),
    )).thenAnswer((_) async => user);

    // act
    final result = await useCase(
      email: 'test@test.com',
      password: '123456',
      firstName: 'John',
      lastName: 'Doe',
      userType: UserType.customer,
      latitude: 30.0,
      longitude: 31.0,
      address: 'Cairo',
      about: 'Dev',
    );

    // assert
    expect(result, user);
    verify(repo.register(
      email: anyNamed('email'),
      password: anyNamed('password'),
      firstName: anyNamed('firstName'),
      lastName: anyNamed('lastName'),
      userType: anyNamed('userType'),
      latitude: anyNamed('latitude'),
      longitude: anyNamed('longitude'),
      address: anyNamed('address'),
      about: anyNamed('about'),
      specialty: anyNamed('specialty'),
    )).called(1);
  });
}