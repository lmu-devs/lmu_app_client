import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/{{feature_name.snakeCase()}}.dart';

import 'cubit/{{feature_name.snakeCase()}}_cubit/cubit.dart';
import 'repository/{{feature_name.snakeCase()}}_repository.dart';
import 'repository/api/{{feature_name.snakeCase()}}_api_client.dart';
import 'services/default_{{feature_name.snakeCase()}}_service.dart';

class {{feature_name.pascalCase()}}Module extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => '{{feature_name.pascalCase()}}Module';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}Service>(Default{{feature_name.pascalCase()}}Service());
  }

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}ApiClient>({{feature_name.pascalCase()}}ApiClient());
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}Repository>(Connected{{feature_name.pascalCase()}}Repository());
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}Cubit>({{feature_name.pascalCase()}}Cubit());
  }
}
