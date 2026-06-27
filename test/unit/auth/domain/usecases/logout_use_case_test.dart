import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:servicenear/features/auth/domain/usercases/logout_use_case.dart';

import '../../../../helpers/mocks.mocks.dart';

void main() {
  late LogoutUseCase useCase;
  late MockAuthRepository repo;

  setUp(() {
    repo = MockAuthRepository();
    useCase = LogoutUseCase(repo);
  });

  test('should call logout from repository', () async {
    // arrange
    when(repo.logout()).thenAnswer((_) async => Future.value());

    // act
    await useCase();

    // assert
    verify(repo.logout()).called(1);
  });
}