import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_type.dart';
import '../../domain/entities/user_location.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/app_user_model.dart';

class AuthRepoImpl implements AuthRepository {
  final SupabaseClient client;

  AuthRepoImpl(this.client);

  @override
  Future<AppUser> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userType,
    required double latitude,
    required double longitude,
    String? specialty,
  }) async {
    // Register in Supabase Auth
    final res = await client.auth.signUp(email: email, password: password);
    final userId = res.user?.id;
    if (userId == null) {
      throw Exception('Failed to create auth user');
    }

    // Insert into table
    final tableName = userType == 'worker' ? 'workers' : 'customers';

    final userModel = AppUserModel(
      id: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      userType: userType == 'worker' ? UserType.worker : UserType.customer,
      location: UserLocation(latitude: latitude, longitude: longitude),
      createdAt: DateTime.now(),
      specialty: specialty,
    );

    final insertRes = await client.from(tableName).insert(userModel.toJson());

    if (insertRes.error != null) {
      // Delete Supabase Auth user if insert failed
      await client.auth.admin.deleteUser(userId);
      throw Exception(
          'Failed to insert user data: ${insertRes.error!.message}');
    }

    return userModel;
  }
}
