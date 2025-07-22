import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/people.dart';
import 'package:get_it/get_it.dart';

import 'application/usecase/get_people_usecase.dart';
import 'application/usecase/favorite_people_usecase.dart';
import 'domain/interface/people_repository_interface.dart';
import 'infrastructure/primary/router/people_router.dart';
import 'infrastructure/secondary/data/api/people_api_client.dart';
import 'infrastructure/secondary/data/storage/people_favorites_storage.dart';
import 'infrastructure/secondary/repository/people_repository.dart';

class PeopleModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'PeopleModule';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final favoritesStorage = PeopleFavoritesStorage();
    final repository = PeopleRepository(PeopleApiClient(baseApiClient));
    final getUsecase = GetPeopleUsecase(repository);
    final favoritesUsecase = FavoritePeopleUsecase(favoritesStorage);

    GetIt.I.registerSingleton<PeopleFavoritesStorage>(favoritesStorage);
    GetIt.I.registerSingleton<PeopleRepositoryInterface>(repository);
    GetIt.I.registerSingleton<GetPeopleUsecase>(getUsecase);
    GetIt.I.registerSingleton<FavoritePeopleUsecase>(favoritesUsecase);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<PeopleRouter>(PeopleRouterImpl());
  }
}
