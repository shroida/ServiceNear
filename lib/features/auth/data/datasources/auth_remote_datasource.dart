abstract class AuthRemoteDataSource {
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
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<bool> isLoggedIn();
}
