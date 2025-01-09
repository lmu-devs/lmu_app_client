import 'dart:convert';

import 'package:core/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import '../repository.dart';

class UserApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<UserModel> createUser() async {
    final systemApiKey = dotenv.env['SYSTEM_API_KEY'];
    if (systemApiKey == null) throw Exception("System API Key not set");

    try {
      final response = await _baseApiClient.post(
        UserApiEndpoints.user,
        additionalHeaders: {
          "system-api-key": systemApiKey,
        },
      );

      return UserModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<String> updateUser() async {
    throw Exception("Not implemented yet");
  }

  Future<void> deleteUser() async {
    try {
      await _baseApiClient.delete(UserApiEndpoints.user);
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
