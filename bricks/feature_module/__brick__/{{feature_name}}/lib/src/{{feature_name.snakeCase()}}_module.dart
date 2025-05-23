import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/{{feature_name.snakeCase()}}.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/{{feature_name.snakeCase()}}.dart';

import 'application/state/{{feature_name.snakeCase()}}_state.dart';
import 'application/usecase/get_cached_{{feature_name.snakeCase()}}_usecase.dart';
import 'application/usecase/get_{{feature_name.snakeCase()}}_usecase.dart';
import 'domain/interface/{{feature_name.snakeCase()}}_repository_interface.dart';
import 'infrastructure/primary/api/{{feature_name.snakeCase()}}_api.dart';
import 'infrastructure/primary/router/{{feature_name.snakeCase()}}_router.dart';
import 'infrastructure/secondary/data/api/{{feature_name.snakeCase()}}_api_client.dart';
import 'infrastructure/secondary/data/storage/{{feature_name.snakeCase()}}_storage.dart';
import 'infrastructure/secondary/repository/{{feature_name.snakeCase()}}_repository.dart';

class {{feature_name.pascalCase()}}Module extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => '{{feature_name.pascalCase()}}Module';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final {{feature_name.snakeCase()}}Storage = {{feature_name.pascalCase()}}Storage();
    final {{feature_name.snakeCase()}}Repository = {{feature_name.pascalCase()}}Repository({{feature_name.pascalCase()}}ApiClient(baseApiClient), {{feature_name.snakeCase()}}Storage);
    final get{{feature_name.pascalCase()}}UseCase = Get{{feature_name.pascalCase()}}Usecase({{feature_name.snakeCase()}}Repository);
    final getCached{{feature_name.pascalCase()}}UseCase = GetCached{{feature_name.pascalCase()}}Usecase({{feature_name.snakeCase()}}Repository);
    final {{feature_name.snakeCase()}}StateService = {{feature_name.pascalCase()}}StateService(get{{feature_name.pascalCase()}}UseCase, getCached{{feature_name.pascalCase()}}UseCase);

    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}RepositoryInterface>({{feature_name.snakeCase()}}Repository);
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}StateService>({{feature_name.snakeCase()}}StateService);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}Api>({{feature_name.pascalCase()}}ApiImpl());
    GetIt.I.registerSingleton<{{feature_name.pascalCase()}}Router>({{feature_name.pascalCase()}}RouterImpl());
  }
}
