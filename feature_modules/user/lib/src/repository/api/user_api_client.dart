import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../repository.dart';

class UserApiClient {
  Future<UserModel> createUser() async {
    final systemApiKey = dotenv.env['SYSTEM_API_KEY'];
    if (systemApiKey == null) throw Exception("System API Key not set");

    try {
      final response = await http.post(
        Uri.parse("${UserApiEndpoints.user}?device_id=123"),
        headers: {
          "system-api-key": systemApiKey,
        },
      );

      return UserModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<String> updateUser(String id) async {
    throw Exception("Not implemented yet");
  }

  Future<void> deleteUser(String apiKey) async {
    try {
      await http.delete(
        Uri.parse(UserApiEndpoints.user),
        headers: {
          "user-api-key": apiKey,
        },
      );
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
