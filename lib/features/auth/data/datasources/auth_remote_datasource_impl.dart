import 'package:servicenear/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase;

  AuthRemoteDataSourceImpl(this.supabase);

  @override
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userType,
    required double latitude,
    required double longitude,
    String? specialty,
    String? phone,
  }) async {
    final authResponse = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = authResponse.user;
    if (user == null) {
      throw Exception('Signup failed');
    }

    Map<String, dynamic> userData;

    if (userType == 'customer') {
      final response = await supabase
          .from('customers')
          .insert({
            'id': user.id,
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'latitude': latitude,
            'longitude': longitude,
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      userData = Map<String, dynamic>.from(response);
    } else {
      final response = await supabase
          .from('workers')
          .insert({
            'id': user.id,
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'phone': phone ?? '',
            'specialty': specialty ?? '',
            'latitude': latitude,
            'longitude': longitude,
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      userData = Map<String, dynamic>.from(response);
    }

    return userData;
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session == null) {
        // Invalid credentials
        throw Exception('Invalid email or password');
      }

      // Save session or navigate to home
    } on AuthApiException catch (e) {
      // This will catch Supabase errors
      print('Auth Error: ${e.message}');
    } catch (e) {
      print('Unexpected Error: $e');
    }
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      print('Logged in success');
      if (response.session == null) {
        // Invalid credentials
        throw Exception('Invalid email or password');
      }

      // Save session or navigate to home
    } on AuthApiException catch (e) {
      print('Auth Error: ${e.message}');
    } catch (e) {
      print('Unexpected Error: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  @override
  Future<bool> isLoggedIn() async {
    return supabase.auth.currentSession != null;
  }
}
