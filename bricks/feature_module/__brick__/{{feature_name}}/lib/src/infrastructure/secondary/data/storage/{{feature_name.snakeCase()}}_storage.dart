import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/{{feature_name.snakeCase()}}_dto.dart';

class {{feature_name.pascalCase()}}Storage {
  final _{{feature_name.snakeCase()}}Key = '{{feature_name.snakeCase()}}_data_key';

  Future<void> save{{feature_name.pascalCase()}}({{feature_name.pascalCase()}}Dto {{feature_name.snakeCase()}}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_{{feature_name.snakeCase()}}Key, jsonEncode({{feature_name.snakeCase()}}.toJson()));
  }

  Future<{{feature_name.pascalCase()}}Dto?> get{{feature_name.pascalCase()}}() async {
    final prefs = await SharedPreferences.getInstance();
    final {{feature_name.snakeCase()}}Json = prefs.getString(_{{feature_name.snakeCase()}}Key);
    if ({{feature_name.snakeCase()}}Json == null) return null;
    final {{feature_name.snakeCase()}}Map = jsonDecode({{feature_name.snakeCase()}}Json);
    return {{feature_name.pascalCase()}}Dto.fromJson({{feature_name.snakeCase()}}Map);
  }

  Future<void> delete{{feature_name.pascalCase()}}() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_{{feature_name.snakeCase()}}Key);
  }
}
