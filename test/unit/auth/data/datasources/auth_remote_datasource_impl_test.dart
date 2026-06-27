import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:servicenear/features/auth/data/datasources/auth_remote_datasource_impl.dart';

import '../../../../helpers/mocks.mocks.dart';
import 'auth_remote_datasource_impl_test.mocks.dart' show MockSession;

// Run: dart run build_runner build
@GenerateMocks([SupabaseClient, GoTrueClient, AuthResponse, Session, User])
void main() {


  late MockSupabaseClient mockSupabase;
  late MockGoTrueClient mockAuth;
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    mockSupabase = MockSupabaseClient();
    mockAuth = MockGoTrueClient();
    when(mockSupabase.auth).thenReturn(mockAuth);
    dataSource = AuthRemoteDataSourceImpl(mockSupabase);
  });

  group('AuthRemoteDataSourceImpl', () {
    // ── isLoggedIn ────────────────────────────────────────────────────────

    group('isLoggedIn()', () {
      test('returns true when a session exists', () async {
        final mockSession = MockSession();
        when(mockAuth.currentSession).thenReturn(mockSession);

        final result = await dataSource.isLoggedIn();

        expect(result, isTrue);
      });

      test('returns false when no session exists', () async {
        when(mockAuth.currentSession).thenReturn(null);

        final result = await dataSource.isLoggedIn();

        expect(result, isFalse);
      });
    });

    // ── signOut ───────────────────────────────────────────────────────────

    group('signOut()', () {
      test('calls supabase.auth.signOut()', () async {
        when(mockAuth.signOut()).thenAnswer((_) async {});

        await dataSource.signOut();

        verify(mockAuth.signOut()).called(1);
      });
    });
  });
}