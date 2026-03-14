abstract class AuthRemoteDataSource {
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
  });

  Future<String> signIn({required String email, required String password});

  Future<void> signOut();

  Future<bool> isLoggedIn();
}
