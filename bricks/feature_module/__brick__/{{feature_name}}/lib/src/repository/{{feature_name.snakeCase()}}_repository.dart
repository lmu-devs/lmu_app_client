import 'package:get_it/get_it.dart';

import 'api/api.dart';

abstract class {{feature_name.pascalCase()}}Repository{
  Future<{{feature_name.pascalCase()}}Model> get{{feature_name.pascalCase()}}();
}

class Connected{{feature_name.pascalCase()}}Repository implements {{feature_name.pascalCase()}}Repository{
  final _apiClient = GetIt.I.get<{{feature_name.pascalCase()}}ApiClient>();

  @override
  Future<{{feature_name.pascalCase()}}Model> get{{feature_name.pascalCase()}}() async {
    return _apiClient.get{{feature_name.pascalCase()}}();
  }
}