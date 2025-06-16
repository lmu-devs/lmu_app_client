import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/people.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'application/state/people_state.dart' as state;
import 'application/usecase/delete_cached_people_usecase.dart';
import 'application/usecase/get_cached_people_usecase.dart';
import 'application/usecase/get_people_usecase.dart';
import 'domain/interface/people_repository_interface.dart';
import 'infrastructure/primary/router/people_router.dart';
import 'infrastructure/secondary/data/api/people_api_client.dart';
import 'infrastructure/secondary/data/storage/people_storage.dart';
import 'infrastructure/secondary/repository/people_repository.dart';
import 'services/people_state_service.dart' as filter;

class PeopleModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, LocalizedDataContainigAppModule {
  @override
  String get moduleName => 'PeopleModule';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final peopleStorage = PeopleStorage();
    final peopleRepository = PeopleRepository(
      PeopleApiClient(
        client: http.Client(),
        baseUrl: '',
      ),
      peopleStorage,
    );
    final getPeopleUseCase = GetPeopleUsecase(peopleRepository);
    final getCachedPeopleUseCase = GetCachedPeopleUsecase(peopleRepository);
    final deleteCachedPeopleUsecase = DeleteCachedPeopleUsecase(peopleRepository);
    final peopleState = state.PeopleStateService(getPeopleUseCase, getCachedPeopleUseCase);
    final peopleFilterState = filter.PeopleStateService();

    GetIt.I.registerSingleton<PeopleRepositoryInterface>(peopleRepository);
    GetIt.I.registerSingleton<state.PeopleStateService>(peopleState);
    GetIt.I.registerSingleton<DeleteCachedPeopleUsecase>(deleteCachedPeopleUsecase);
    GetIt.I.registerSingleton<filter.PeopleStateService>(peopleFilterState, instanceName: 'filter');
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
