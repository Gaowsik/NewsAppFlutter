abstract class SessionLocalDataSource {
  Future<void> insertCurrentUserEmail(String email);

  Future<void> updateIsLoggedIn(bool isLoggedIn);

  Future<void> logOut();

  Future<String> getCurrentUserEmail();

  Future<bool> isLoggedIn();
}
