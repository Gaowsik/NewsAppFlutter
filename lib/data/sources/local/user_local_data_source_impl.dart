import 'package:hive_flutter/adapters.dart';
import 'package:untitled/data/sources/local/entities/user/user_entity.dart';
import 'package:untitled/data/sources/local/user_local_data_source.dart';
import 'package:untitled/domain/User.dart';
import 'package:untitled/utils/app_strings.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<User> getCurrentUser(String email) async {
    final usersBox = await Hive.openBox<UserEntity>(userBox);
    final userEntity = usersBox.get(email);

    if (userEntity == null) {
      throw Exception("User not found");
    }
    return userEntity.toDomain();
  }

  @override
  Future<void> insertUser(User user) async {
    final box = await Hive.openBox<UserEntity>(userBox);
    await box.put(user.email, UserEntity.fromDomainUser(user));
  }


  @override
  Future<bool> login({required String email, required String password}) async {
    final usersBox = await Hive.openBox<UserEntity>(userBox);
    final user = usersBox.get(email);
    if (user == null) return false;
    if (user.password != password) return false;
    return true;
  }

}
