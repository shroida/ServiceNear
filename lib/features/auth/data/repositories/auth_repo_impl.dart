import 'package:servicenear/features/auth/data/models/app_user_model.dart';
import 'package:servicenear/features/auth/domain/entities/app_user.dart';
import 'package:servicenear/features/auth/domain/entities/user_type.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl implements AuthRepository {
  final SupabaseClient client;

  @override
  Future<AppUser> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String userType,
      required double latitude,
      required double longitude,
      String? specialty}) async {
    // 1️⃣ Create user in Supabase Auth
    final res = await client.auth.signUp(
      email: email,
      password: password,
    );

    final userId = res.user?.id;
    if (userId == null) {
      throw Exception('Failed to create auth user');
    }

    // 2️⃣ Insert into table based on userType
    final tableName = userType == 'worker' ? 'worker' : 'customer';

    final userMap = AppUserModel(
      id: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      userType: userType,
      latitude: latitude,
      longitude: longitude,
    ).toJson();
  }
}
