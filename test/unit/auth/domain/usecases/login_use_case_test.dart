import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/features/auth/domain/usercases/login_use_case.dart';

import '../../../../helpers/mocks.mocks.dart';

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository repo;

  setUp(() {
    repo = MockAuthRepository();
    useCase = LoginUseCase(repo);
  });

  test('should return AppUser when login is successful', () async {
    // arrange
    const email = 'test@test.com';
    const password = '123456';

    final user = AppUser(
      location: UserLocation(latitude: 0.0, longitude: 0.0) ,
      userType: UserType.customer,
      createdAt: DateTime.now(),
      firstName: 'John',
      lastName: 'Doe',
      

      id: '1',
      email: email,
    );

    when(repo.login(email: email, password: password))
        .thenAnswer((_) async => user);

    // act
    final result = await useCase(email, password);

    // assert
    expect(result, user);
    verify(repo.login(email: email, password: password)).called(1);
  });
}