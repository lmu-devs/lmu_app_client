import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import '{{feature_name.snakeCase()}}_api_endpoints.dart';
import 'models/{{feature_name.snakeCase()}}_model.dart';

class {{feature_name.pascalCase()}}ApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>(); 

  Future<{{feature_name.pascalCase()}}Model> get{{feature_name.pascalCase()}}() async {
    final response = await _baseApiClient.get({{feature_name.pascalCase()}}ApiEndpoints.{{feature_name}});
    return {{feature_name.pascalCase()}}Model.fromJson(jsonDecode(response.body));
  }
}