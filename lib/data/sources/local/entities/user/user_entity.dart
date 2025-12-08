import 'package:hive_flutter/adapters.dart';

import '../../../../../domain/User.dart' show User;


part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity extends HiveObject {
  @HiveField(0)
  final String firstName;

  @HiveField(1)
  final String lastName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  UserEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  factory UserEntity.fromDomainUser(User a) => UserEntity(
    firstName: a.firstName,
    lastName: a.lastName,
    email: a.email,
    password: a.password,
  );

  User toDomain() => User(
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
  );
}
