import 'package:untitled/domain/user.dart';

import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserLocalDataSource userLocalDataSource;
  final SessionLocalDataSource sessionLocalDataSource;

  UserRepositoryImpl(this.userLocalDataSource, this.sessionLocalDataSource);


  @override
  Future<User> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<void> insertUser(User user) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() {
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    throw UnimplementedError();
  }

  @override
  Future<User> login({required String email, required String password}) {
    throw UnimplementedError();
  }

}