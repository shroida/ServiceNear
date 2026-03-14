import 'package:servicenear/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase;

  AuthRemoteDataSourceImpl(this.supabase);

  @override
  Future<String> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userType,
    required double latitude,
    required double longitude,
    String? specialty,
    String? phone,
    String? address,
    String? about,
  }) async {
    final authResponse = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = authResponse.user;

    if (user == null) {
      throw Exception('Signup failed');
    }

    if (userType == 'customer') {
      await supabase.from('customers').insert({
        'id': user.id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'latitude': latitude,
        'longitude': longitude,
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      await supabase.from('workers').insert({
        'id': user.id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone ?? '',
        'specialty': specialty ?? '',
        'address': address ?? '',
        'about': about ?? '',
        'latitude': latitude,
        'longitude': longitude,
        'created_at': DateTime.now().toIso8601String(),
      });
    }

    return user.id;
  }

  @override
  Future<String> signIn({
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

    return response.user!.id;
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
