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

    if (user == null) throw Exception('Signup failed');

    final tableData = {
      'id': user.id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': DateTime.now().toIso8601String(),
    };

    if (userType == 'worker') {
      tableData.addAll({
        'phone': phone ?? '',
        'specialty': specialty ?? '',
        'address': address ?? '',
        'about': about ?? '',
      });
    }

    final table = userType == 'customer' ? 'customers' : 'workers';
    await supabase.from(table).insert(tableData);

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
    if (response.user == null) throw Exception('Invalid login credentials');
    return response.user!.id;
  }

  @override
  Future<void> signOut() => supabase.auth.signOut();

  @override
  Future<bool> isLoggedIn() =>
      Future.value(supabase.auth.currentSession != null);
}
