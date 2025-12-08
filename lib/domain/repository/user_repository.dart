import '../user.dart';

abstract class UserRepository {
  Future<void> insertUser(User user);

  Future<User> login({required String email, required String password});

  Future<void> logOut();

  Future<User> getCurrentUser();

  Future<bool> isLoggedIn();
}
