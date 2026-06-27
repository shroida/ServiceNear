import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:servicenear/features/auth/domain/usercases/login_use_case.dart';
import 'package:servicenear/features/auth/domain/usercases/logout_use_case.dart';
import 'package:servicenear/features/auth/domain/usercases/register_use_case.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:servicenear/features/auth/presentation/cubit/app_auth_state.dart';

import '../helpers/mocks.mocks.dart';

void main() {
  late MockAuthRemoteDataSource mockRemote;
  late MockUserRepository mockUserRepo;
  late AuthRepositoryImpl authRepo;
  late LoginUseCase loginUseCase;
  late LogoutUseCase logoutUseCase;
  late RegisterUseCase registerUseCase;
  late AuthCubit cubit;

  const uid = 'integration-uid';
  const email = 'integration@test.com';
  const password = 'IntPass99!';

  AppUser fakeUser() => AppUser(
        id: uid,
        email: email,
        firstName: 'Integration',
        lastName: 'User',
        location: UserLocation(latitude: 30.05, longitude: 31.23),
        userType: UserType.customer,
        createdAt: DateTime(2024, 3, 15),
      );

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    mockUserRepo = MockUserRepository();

    authRepo = AuthRepositoryImpl(
      remoteDataSource: mockRemote,
      userRepository: mockUserRepo,
    );

    loginUseCase = LoginUseCase(authRepo);
    logoutUseCase = LogoutUseCase(authRepo);
    registerUseCase = RegisterUseCase(authRepo);
    cubit = AuthCubit(authRepo, mockUserRepo);
  });

  tearDown(() => cubit.close());

  // ── register → login → logout flow ──────────────────────────────────────

  group('Full auth lifecycle', () {
    test('register succeeds end-to-end through all layers', () async {
      final user = fakeUser();

      when(mockRemote.signUp(
        email: email,
        password: password,
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        userType: 'customer',
        latitude: anyNamed('latitude'),
        longitude: anyNamed('longitude'),
        specialty: anyNamed('specialty'),
        phone: anyNamed('phone'),
        address: anyNamed('address'),
        about: anyNamed('about'),
      )).thenAnswer((_) async => uid);

      when(mockUserRepo.getUserById(uid)).thenAnswer((_) async => user);

      final result = await registerUseCase(
        email: email,
        password: password,
        firstName: 'Integration',
        lastName: 'User',
        userType: UserType.customer,
        latitude: 30.05,
        longitude: 31.23,
        address: 'Cairo',
        about: 'Tester',
      );

      expect(result.id, uid);
      expect(result.email, email);
    });

    test('login succeeds end-to-end through all layers', () async {
      final user = fakeUser();

      when(mockRemote.signIn(email: email, password: password))
          .thenAnswer((_) async => uid);
      when(mockUserRepo.getUserById(uid)).thenAnswer((_) async => user);

      final result = await loginUseCase(email, password);

      expect(result.id, uid);
      expect(result.userType, UserType.customer);
    });

    test('logout succeeds end-to-end through all layers', () async {
      when(mockRemote.signOut()).thenAnswer((_) async {});

      await logoutUseCase();

      verify(mockRemote.signOut()).called(1);
    });

    test('register → login → logout sequence works without errors', () async {
      final user = fakeUser();

      // Register
      when(mockRemote.signUp(
        email: email,
        password: password,
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        userType: anyNamed('userType'),
        latitude: anyNamed('latitude'),
        longitude: anyNamed('longitude'),
        specialty: anyNamed('specialty'),
        phone: anyNamed('phone'),
        address: anyNamed('address'),
        about: anyNamed('about'),
      )).thenAnswer((_) async => uid);
      when(mockUserRepo.getUserById(uid)).thenAnswer((_) async => user);

      final registered = await registerUseCase(
        email: email,
        password: password,
        firstName: 'Integration',
        lastName: 'User',
        userType: UserType.customer,
        latitude: 30.0,
        longitude: 31.0,
        address: 'Cairo',
        about: '',
      );
      expect(registered.id, uid);

      // Login
      when(mockRemote.signIn(email: email, password: password))
          .thenAnswer((_) async => uid);

      final loggedIn = await loginUseCase(email, password);
      expect(loggedIn.id, uid);

      // Logout
      when(mockRemote.signOut()).thenAnswer((_) async {});
      await logoutUseCase();
      verify(mockRemote.signOut()).called(1);
    });
  });

  // ── cubit integration ────────────────────────────────────────────────────

  group('AuthCubit integration with real repo + use cases', () {
    test('cubit.login() emits AuthLoggedIn when everything succeeds', () async {
      final user = fakeUser();

      when(mockRemote.signIn(email: email, password: password))
          .thenAnswer((_) async => uid);
      when(mockUserRepo.getUserById(uid)).thenAnswer((_) async => user);
      when(mockUserRepo.getCurrentUser()).thenAnswer((_) async => user);

      cubit.emailController.text = email;
      cubit.passwordController.text = password;

      final states = <AppAuthState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.login(email: email, password: password);
      await sub.cancel();

      expect(states, [isA<AuthLoading>(), isA<AuthLoggedIn>()]);
      expect((states.last as AuthLoggedIn).user.id, uid);
    });

    test('cubit.logout() emits AuthInitial and clears controllers', () async {
      when(mockRemote.signOut()).thenAnswer((_) async {});

      cubit.emailController.text = email;
      cubit.passwordController.text = password;

      final states = <AppAuthState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.logout();
      await sub.cancel();

      expect(states, [isA<AuthLoading>(), isA<AuthInitial>()]);
      expect(cubit.emailController.text, isEmpty);
      expect(cubit.passwordController.text, isEmpty);
    });

    test('error state message is non-empty when login fails', () async {
      when(mockRemote.signIn(email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(Exception('Network timeout'));
      when(mockUserRepo.getCurrentUser()).thenAnswer((_) async => null);

      cubit.emailController.text = email;
      cubit.passwordController.text = password;
      await cubit.login(email: email, password: password);

      expect(cubit.state, isA<AuthError>());
      expect((cubit.state as AuthError).message, isNotEmpty);
    });
  });
}