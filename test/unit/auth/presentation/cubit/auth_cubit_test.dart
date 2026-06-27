import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:servicenear/features/auth/presentation/cubit/app_auth_state.dart';

import '../../../../helpers/mocks.mocks.dart';

void main() {
  late AuthCubit cubit;
  late MockAuthRepository mockAuthRepo;
  late MockUserRepository mockUserRepo;

  AppUser fakeUser() => AppUser(
        id: 'uid-1',
        email: 'user@test.com',
        firstName: 'Ali',
        lastName: 'Hassan',
        location: UserLocation(latitude: 30.0, longitude: 31.0),
        userType: UserType.customer,
        createdAt: DateTime(2024, 1, 1),
      );

  setUp(() {
    mockAuthRepo = MockAuthRepository();
    mockUserRepo = MockUserRepository();
    cubit = AuthCubit(mockAuthRepo, mockUserRepo);
  });

  tearDown(() => cubit.close());

  // ── initial state ────────────────────────────────────────────────────────

  group('initial state', () {
    test('is AuthInitial', () {
      expect(cubit.state, isA<AuthInitial>());
    });

    test('currentUserId is empty on AuthInitial', () {
      expect(cubit.state.currentUserId, isEmpty);
    });
  });

  // ── login ────────────────────────────────────────────────────────────────

  group('login()', () {
    blocTest<AuthCubit, AppAuthState>(
      'emits [AuthLoading, AuthLoggedIn] on success',
      build: () {
        when(mockAuthRepo.login(
                email: anyNamed('email'), password: anyNamed('password')))
            .thenAnswer((_) async => fakeUser());
        when(mockUserRepo.getCurrentUser())
            .thenAnswer((_) async => fakeUser());
        return AuthCubit(mockAuthRepo, mockUserRepo);
      },
      act: (c) {
        c.emailController.text = 'user@test.com';
        c.passwordController.text = 'password123';

        return c.login(email: c.emailController.text.trim(), password: c.passwordController.text.trim());
      },
      expect: () => [isA<AuthLoading>(), isA<AuthLoggedIn>()],
    );

    blocTest<AuthCubit, AppAuthState>(
      'emits [AuthLoading, AuthError] when repository throws',
      build: () {
        when(mockAuthRepo.login(
                email: anyNamed('email'), password: anyNamed('password')))
            .thenThrow(Exception('Bad credentials'));
        return AuthCubit(mockAuthRepo, mockUserRepo);
      },
      act: (c) {
        c.emailController.text = 'bad@test.com';
        c.passwordController.text = 'wrongpass';
        return c.login(email: c.emailController.text.trim(), password: c.passwordController.text.trim());
      },
      expect: () => [isA<AuthLoading>(), isA<AuthError>()],
    );

    blocTest<AuthCubit, AppAuthState>(
      'emits [AuthLoading, AuthError] when getCurrentUser returns null',
      build: () {
        when(mockAuthRepo.login(
                email: anyNamed('email'), password: anyNamed('password')))
            .thenAnswer((_) async => fakeUser());
        when(mockUserRepo.getCurrentUser()).thenAnswer((_) async => null);
        return AuthCubit(mockAuthRepo, mockUserRepo);
      },
      act: (c) {
        c.emailController.text = 'user@test.com';
        c.passwordController.text = 'pass';
        return c.login(email: c.emailController.text.trim(), password: c.passwordController.text.trim());
      },
      expect: () => [isA<AuthLoading>(), isA<AuthError>()],
    );

    test('AuthError contains a non-empty message on failure', () async {
      when(mockAuthRepo.login(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(Exception('Timeout'));
      when(mockUserRepo.getCurrentUser()).thenAnswer((_) async => null);

      cubit.emailController.text = 'x@x.com';
      cubit.passwordController.text = 'p';
      await cubit.login(email: cubit.emailController.text.trim(), password: cubit.passwordController.text.trim());

      final state = cubit.state;
      expect(state, isA<AuthError>());
      expect((state as AuthError).message, isNotEmpty);
    });

    test('AuthLoggedIn state holds the correct user', () async {
      final user = fakeUser();
      when(mockAuthRepo.login(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => user);
      when(mockUserRepo.getCurrentUser()).thenAnswer((_) async => user);

      cubit.emailController.text = 'user@test.com';
      cubit.passwordController.text = 'password123';
      await cubit.login(email: cubit.emailController.text.trim(), password: cubit.passwordController.text.trim());

      final state = cubit.state;
      expect(state, isA<AuthLoggedIn>());
      expect((state as AuthLoggedIn).user.id, equals('uid-1'));
    });
  });

  // ── logout ───────────────────────────────────────────────────────────────

  group('logout()', () {
    blocTest<AuthCubit, AppAuthState>(
      'emits [AuthLoading, AuthInitial] on success',
      build: () {
        when(mockAuthRepo.logout()).thenAnswer((_) async {});
        return AuthCubit(mockAuthRepo, mockUserRepo);
      },
      act: (c) => c.logout(),
      expect: () => [isA<AuthLoading>(), isA<AuthInitial>()],
    );

    blocTest<AuthCubit, AppAuthState>(
      'emits [AuthLoading, AuthError] when logout throws',
      build: () {
        when(mockAuthRepo.logout()).thenThrow(Exception('Logout error'));
        return AuthCubit(mockAuthRepo, mockUserRepo);
      },
      act: (c) => c.logout(),
      expect: () => [isA<AuthLoading>(), isA<AuthError>()],
    );

    test('clears email and password controllers after logout', () async {
      when(mockAuthRepo.logout()).thenAnswer((_) async {});

      cubit.emailController.text = 'user@test.com';
      cubit.passwordController.text = 'secret';
      await cubit.logout();

      expect(cubit.emailController.text, isEmpty);
      expect(cubit.passwordController.text, isEmpty);
    });
  });

  // ── register ─────────────────────────────────────────────────────────────

  group('register()', () {
    blocTest<AuthCubit, AppAuthState>(
      'emits [AuthLoading, AuthSuccess] on success',
      build: () {
        when(mockAuthRepo.register(
          email: anyNamed('email'),
          password: anyNamed('password'),
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          userType: anyNamed('userType'),
          latitude: anyNamed('latitude'),
          longitude: anyNamed('longitude'),
          specialty: anyNamed('specialty'),
          phone: anyNamed('phone'),
          address: anyNamed('address'),
          about: anyNamed('about'),
        )).thenAnswer((_) async => fakeUser());
        return AuthCubit(mockAuthRepo, mockUserRepo);
      },
      act: (c) {
        c.emailController.text = 'new@test.com';
        c.passwordController.text = 'pass123';
        c.firstNameController.text = 'Ali';
        c.lastNameController.text = 'Hassan';
        return c.register(
          email: c.emailController.text.trim(),
          password: c.passwordController.text.trim(),
          firstName: c.firstNameController.text.trim(),
          lastName: c.lastNameController.text.trim(),
          latitude: 30.0,
          longitude: 31.0,
        );
      },
      expect: () => [isA<AuthLoading>(), isA<AuthSuccess>()],
    );

    blocTest<AuthCubit, AppAuthState>(
      'emits [AuthLoading, AuthError] when registration throws',
      build: () {
        when(mockAuthRepo.register(
          email: anyNamed('email'),
          password: anyNamed('password'),
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          userType: anyNamed('userType'),
          latitude: anyNamed('latitude'),
          longitude: anyNamed('longitude'),
          specialty: anyNamed('specialty'),
          phone: anyNamed('phone'),
          address: anyNamed('address'),
          about: anyNamed('about'),
        )).thenThrow(Exception('Email taken'));
        return AuthCubit(mockAuthRepo, mockUserRepo);
      },
      act: (c) {
        c.emailController.text = 'taken@test.com';
        c.passwordController.text = 'pass';
        c.firstNameController.text = 'A';
        c.lastNameController.text = 'B';
        return c.register(
          email: c.emailController.text.trim(),
          password: c.passwordController.text.trim(),
          firstName: c.firstNameController.text.trim(),
          lastName: c.lastNameController.text.trim(),
          latitude: 30.0,
          longitude: 31.0,
        );
      },
      expect: () => [isA<AuthLoading>(), isA<AuthError>()],
    );
  });

  // ── UI helpers ───────────────────────────────────────────────────────────

  group('UI state helpers', () {
    test('togglePasswordVisibility flips isPasswordVisible and emits AuthInitial', () {
      expect(cubit.isPasswordVisible, isFalse);
      cubit.togglePasswordVisibility();
      expect(cubit.isPasswordVisible, isTrue);
      expect(cubit.state, isA<AuthInitial>());
    });

    test('changeUserType updates selectedUserType and emits AuthInitial', () {
      cubit.changeUserType(UserType.worker);
      expect(cubit.selectedUserType, UserType.worker);
      expect(cubit.state, isA<AuthInitial>());
    });

    test('changeSpecialty updates selectedSpecialty and emits AuthInitial', () {
      cubit.changeSpecialty('Electrician');
      expect(cubit.selectedSpecialty, 'Electrician');
      expect(cubit.state, isA<AuthInitial>());
    });

    test('changeSpecialty accepts null', () {
      cubit.changeSpecialty(null);
      expect(cubit.selectedSpecialty, isNull);
    });
  });

  // ── AppAuthState helpers ──────────────────────────────────────────────────

  group('AppAuthState.currentUserId', () {
    test('AuthInitial returns empty string', () {
      expect(AuthInitial().currentUserId, isEmpty);
    });

    test('AuthAuthenticated returns user id', () {
      final user = fakeUser();
      expect(AuthAuthenticated(user).currentUserId, equals('uid-1'));
    });

    test('AuthLoading returns empty string', () {
      expect(AuthLoading().currentUserId, isEmpty);
    });

    test('AuthError returns empty string', () {
      expect(AuthError('err').currentUserId, isEmpty);
    });
  });
}