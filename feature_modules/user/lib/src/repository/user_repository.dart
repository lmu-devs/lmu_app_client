import 'package:shared_preferences/shared_preferences.dart';

import 'api/user_api_client.dart';

abstract class UserRepository {
  Future<String> createUser();

  Future<String?> getUser();

  Future<void> updateUser();

  Future<void> deleteUser();
}

class ConnectedUserRepository implements UserRepository {
  ConnectedUserRepository({required this.userApi});

  final UserApiClient userApi;

  static const _userApiStorageKey = 'user_api_key';

  @override
  Future<String> createUser() async {
    final user = await userApi.createUser();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userApiStorageKey, user.apiKey);

    return user.apiKey;
  }

  @override
  Future<void> deleteUser() async {
    await userApi.deleteUser();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userApiStorageKey);
  }

  @override
  Future<void> updateUser() async {
    await userApi.updateUser();
  }

  @override
  Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userApiKey = prefs.getString(_userApiStorageKey);
    return userApiKey;
  }
}
