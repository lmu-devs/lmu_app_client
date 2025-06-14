import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/people.dart';
import 'package:get_it/get_it.dart';

import 'application/state/people_state.dart';
import 'application/usecase/delete_cached_people_usecase.dart';
import 'application/usecase/get_cached_people_usecase.dart';
import 'application/usecase/get_people_usecase.dart';
import 'domain/interface/people_repository_interface.dart';
import 'infrastructure/primary/router/people_router.dart';
import 'infrastructure/secondary/data/api/people_api_client.dart';
import 'infrastructure/secondary/data/storage/people_storage.dart';
import 'infrastructure/secondary/repository/people_repository.dart';

class PeopleModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, LocalizedDataContainigAppModule {
  @override
  String get moduleName => 'FeedbackModule';
  //@override
  //String get moduleName => 'PeopleModule';

  // Instanzen erstellen und registrieren
  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final peopleStorage = PeopleStorage();
    final peopleRepository = PeopleRepository(PeopleApiClient(baseApiClient), peopleStorage);
    final getPeopleUseCase = GetPeopleUsecase(peopleRepository);
    final getCachedPeopleUseCase = GetCachedPeopleUsecase(peopleRepository);
    final deleteCachedPeopleUsecase = DeleteCachedPeopleUsecase(peopleRepository);
    final peopleState = PeopleStateService(getPeopleUseCase, getCachedPeopleUseCase);

    GetIt.I.registerSingleton<PeopleRepositoryInterface>(peopleRepository);
    GetIt.I.registerSingleton<PeopleStateService>(peopleState);
    GetIt.I.registerSingleton<DeleteCachedPeopleUsecase>(deleteCachedPeopleUsecase);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<PeopleRouter>(PeopleRouterImpl());
  }

  @override
  void onLocaleChange() {
    GetIt.I.get<DeleteCachedPeopleUsecase>().call();
  }
}
