import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/people.dart';
import 'package:get_it/get_it.dart';

import 'application/usecase/get_people_usecase.dart';
import 'domain/interface/people_repository_interface.dart';
import 'infrastructure/primary/router/people_router.dart';
import 'infrastructure/secondary/data/api/people_api_client.dart';
import 'infrastructure/secondary/data/storage/people_storage.dart';
import 'infrastructure/secondary/repository/people_repository.dart';

class PeopleModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'PeopleModule';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final storage = PeopleStorage();
    final repository = PeopleRepository(PeopleApiClient(baseApiClient), storage);
    final getUsecase = GetPeopleUsecase(repository);

    GetIt.I.registerSingleton<PeopleRepositoryInterface>(repository);
    GetIt.I.registerSingleton<GetPeopleUsecase>(getUsecase);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<PeopleRouter>(PeopleRouterImpl());
  }
}
