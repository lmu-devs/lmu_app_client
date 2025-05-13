import 'dart:convert';

import 'package:core/api.dart';

import '../dto/{{feature_name.snakeCase()}}_dto.dart';
import '{{feature_name.snakeCase()}}_api_endpoints.dart';

class {{feature_name.pascalCase()}}ApiClient {
  const {{feature_name.pascalCase()}}ApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient; 

  Future<{{feature_name.pascalCase()}}Dto> get{{feature_name.pascalCase()}}() async {
    final response = await _baseApiClient.get({{feature_name.pascalCase()}}ApiEndpoints.{{feature_name}});
    return {{feature_name.pascalCase()}}Dto.fromJson(jsonDecode(response.body));
  }
}
