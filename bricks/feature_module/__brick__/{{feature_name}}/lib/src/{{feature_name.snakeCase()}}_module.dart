import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/{{feature_name.snakeCase()}}.dart';

import 'services/default_{{feature_name.snakeCase()}}_service.dart';
import 'cubit/{{feature_name.snakeCase()}}_cubit/cubit.dart';

class {{feature_name.pascalCase()}}Module extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => '{{feature_name.pascalCase()}}Module';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}Service>(Default{{feature_name.pascalCase()}}Service());
  }

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}Cubit>({{feature_name.pascalCase()}}Cubit());
  }
}
