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
    String? phone, // لو worker
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

      if (response == null) {
        throw Exception('Adding customer data failed');
      }

      userData = Map<String, dynamic>.from(response);
    } else {
      // worker
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

      if (response == null) {
        throw Exception('Adding worker data failed');
      }

      userData = Map<String, dynamic>.from(response);
    }

    return userData; // هيرجع JSON من الجدول المناسب
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.session == null) {
      throw Exception('Login failed');
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
