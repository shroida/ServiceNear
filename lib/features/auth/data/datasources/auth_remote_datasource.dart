abstract class AuthRemoteDataSource {
  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> signOut();

  Future<bool> isLoggedIn();
}
