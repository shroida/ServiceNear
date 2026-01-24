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
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Invalid login credentials');
    }

    final userId = response.user!.id;

    final customer = await supabase
        .from('customers')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (customer != null) {
      return Map<String, dynamic>.from(customer)..['user_type'] = 'customer';
    }

    final worker = await supabase
        .from('workers')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (worker != null) {
      return Map<String, dynamic>.from(worker)..['user_type'] = 'worker';
    }

    throw Exception('User not found');
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
