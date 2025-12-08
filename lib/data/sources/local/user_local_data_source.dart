import '../../../domain/User.dart';

abstract class UserLocalDataSource {
  Future<void> insertUser(User user);

  Future<bool> login({required String email, required String password});

  Future<User> getCurrentUser(String email);
}
