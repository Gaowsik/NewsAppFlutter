import 'package:hive_flutter/adapters.dart';
import 'package:untitled/data/sources/local/session_local_data_source.dart';

import '../../../utils/app_strings.dart';

class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  Future<Box> _openBox() async {
    return await Hive.openBox(sessionBox);
  }

  @override
  Future<String> getCurrentUserEmail() async {
    final box = await _openBox();
    final email = box.get("email");
    if (email == null) {
      throw Exception("No current user found");
    }
    return email;
  }

  @override
  Future<void> insertCurrentUserEmail(String email) async {
    final box = await _openBox();
    await box.put("email", email);
  }

  @override
  Future<bool> isLoggedIn() async {
    final box = await _openBox();
    return box.get("loggedIn", defaultValue: false);
  }

  @override
  Future<void> logOut() async {
    final box = await _openBox();
    await box.delete("email");
    await box.put("loggedIn", false);
  }

  @override
  Future<void> updateIsLoggedIn(bool isLoggedIn) async {
    final box = await _openBox();
    await box.put("loggedIn", isLoggedIn);
  }
}
