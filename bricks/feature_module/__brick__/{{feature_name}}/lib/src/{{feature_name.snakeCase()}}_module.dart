import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/{{feature_name.snakeCase()}}.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/{{feature_name.snakeCase()}}.dart';

import 'application/usecase/get_{{feature_name.snakeCase()}}_usecase.dart';
import 'domain/interface/{{feature_name.snakeCase()}}_repository_interface.dart';
import 'infrastructure/primary/api/{{feature_name.snakeCase()}}_api.dart';
import 'infrastructure/primary/router/{{feature_name.snakeCase()}}_router.dart';
import 'infrastructure/secondary/data/api/{{feature_name.snakeCase()}}_api_client.dart';
import 'infrastructure/secondary/data/storage/{{feature_name.snakeCase()}}_storage.dart';
import 'infrastructure/secondary/repository/{{feature_name.snakeCase()}}_repository.dart';

class {{feature_name.pascalCase()}}Module extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  
  @override
  String get moduleName => '{{feature_name.pascalCase()}}Module';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final storage = {{feature_name.pascalCase()}}Storage();
    final repository = {{feature_name.pascalCase()}}Repository({{feature_name.pascalCase()}}ApiClient(baseApiClient), storage);
    final getUsecase = Get{{feature_name.pascalCase()}}Usecase(repository);

    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}RepositoryInterface>(repository);
    GetIt.I.registerSingleton<Get{{feature_name.pascalCase()}}Usecase>(getUsecase);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}Api>({{feature_name.pascalCase()}}ApiImpl());
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}Router>({{feature_name.pascalCase()}}RouterImpl());
  }
}
