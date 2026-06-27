import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/features/auth/data/repositories/auth_repo_impl.dart';

import '../../../../helpers/mocks.mocks.dart';

void main() {
  late AuthRepositoryImpl repo;
  late MockAuthRemoteDataSource mockRemote;
  late MockUserRepository mockUserRepo;

  const testEmail = 'test@test.com';
  const testPassword = 'password123';
  const testUserId = 'uid-123';

  AppUser fakeUser({UserType type = UserType.customer}) => AppUser(
        id: testUserId,
        email: testEmail,
        firstName: 'Jane',
        lastName: 'Smith',
        location: UserLocation(latitude: 30.0, longitude: 31.0),
        userType: type,
        createdAt: DateTime(2024, 6, 1),
      );

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    mockUserRepo = MockUserRepository();
    repo = AuthRepositoryImpl(
      remoteDataSource: mockRemote,
      userRepository: mockUserRepo,
    );
  });

  // ── register ─────────────────────────────────────────────────────────────

  group('AuthRepositoryImpl.register()', () {
    test('calls signUp then getUserById, returns AppUser', () async {
      final user = fakeUser();

      when(mockRemote.signUp(
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
      )).thenAnswer((_) async => testUserId);

      when(mockUserRepo.getUserById(testUserId))
          .thenAnswer((_) async => user);

      final result = await repo.register(
        email: testEmail,
        password: testPassword,
        firstName: 'Jane',
        lastName: 'Smith',
        userType: UserType.customer,
        latitude: 30.0,
        longitude: 31.0,
      );

      expect(result, equals(user));
      verify(mockRemote.signUp(
        email: testEmail,
        password: testPassword,
        firstName: 'Jane',
        lastName: 'Smith',
        userType: 'customer',
        latitude: 30.0,
        longitude: 31.0,
        specialty: null,
        phone: null,
        address: null,
        about: null,
      )).called(1);
      verify(mockUserRepo.getUserById(testUserId)).called(1);
    });

    test('passes worker userType as "worker" string to remote', () async {
      final user = fakeUser(type: UserType.worker);

      when(mockRemote.signUp(
        email: anyNamed('email'),
        password: anyNamed('password'),
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        userType: 'worker',
        latitude: anyNamed('latitude'),
        longitude: anyNamed('longitude'),
        specialty: anyNamed('specialty'),
        phone: anyNamed('phone'),
        address: anyNamed('address'),
        about: anyNamed('about'),
      )).thenAnswer((_) async => testUserId);

      when(mockUserRepo.getUserById(testUserId))
          .thenAnswer((_) async => user);

      await repo.register(
        email: testEmail,
        password: testPassword,
        firstName: 'Jane',
        lastName: 'Smith',
        userType: UserType.worker,
        latitude: 30.0,
        longitude: 31.0,
      );

      verify(mockRemote.signUp(
        email: anyNamed('email'),
        password: anyNamed('password'),
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        userType: 'worker',
        latitude: anyNamed('latitude'),
        longitude: anyNamed('longitude'),
        specialty: anyNamed('specialty'),
        phone: anyNamed('phone'),
        address: anyNamed('address'),
        about: anyNamed('about'),
      )).called(1);
    });

    test('throws when getUserById returns null after signUp', () async {
      when(mockRemote.signUp(
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
      )).thenAnswer((_) async => testUserId);

      when(mockUserRepo.getUserById(testUserId)).thenAnswer((_) async => null);

      expect(
        () => repo.register(
          email: testEmail,
          password: testPassword,
          firstName: 'Jane',
          lastName: 'Smith',
          userType: UserType.customer,
          latitude: 30.0,
          longitude: 31.0,
        ),
        throwsException,
      );
    });

    test('propagates exception from signUp', () async {
      when(mockRemote.signUp(
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
      )).thenThrow(Exception('Signup failed'));

      expect(
        () => repo.register(
          email: testEmail,
          password: testPassword,
          firstName: 'Jane',
          lastName: 'Smith',
          userType: UserType.customer,
          latitude: 30.0,
          longitude: 31.0,
        ),
        throwsException,
      );
    });
  });

  // ── login ────────────────────────────────────────────────────────────────

  group('AuthRepositoryImpl.login()', () {
    test('calls signIn then getUserById, returns AppUser', () async {
      final user = fakeUser();

      when(mockRemote.signIn(email: testEmail, password: testPassword))
          .thenAnswer((_) async => testUserId);

      when(mockUserRepo.getUserById(testUserId))
          .thenAnswer((_) async => user);

      final result = await repo.login(
          email: testEmail, password: testPassword);

      expect(result, equals(user));
      verify(mockRemote.signIn(email: testEmail, password: testPassword))
          .called(1);
      verify(mockUserRepo.getUserById(testUserId)).called(1);
    });

    test('throws when getUserById returns null after signIn', () async {
      when(mockRemote.signIn(email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => testUserId);

      when(mockUserRepo.getUserById(testUserId)).thenAnswer((_) async => null);

      expect(
        () => repo.login(email: testEmail, password: testPassword),
        throwsException,
      );
    });

    test('propagates exception from signIn', () async {
      when(mockRemote.signIn(email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(Exception('Invalid credentials'));

      expect(
        () => repo.login(email: testEmail, password: testPassword),
        throwsException,
      );
    });
  });

  // ── logout ───────────────────────────────────────────────────────────────

  group('AuthRepositoryImpl.logout()', () {
    test('delegates to remoteDataSource.signOut()', () async {
      when(mockRemote.signOut()).thenAnswer((_) async {});

      await repo.logout();

      verify(mockRemote.signOut()).called(1);
      verifyNever(mockUserRepo.getUserById(any));
    });

    test('propagates exception from signOut', () async {
      when(mockRemote.signOut())
          .thenThrow(Exception('Sign-out error'));

      expect(() => repo.logout(), throwsException);
    });
  });
}