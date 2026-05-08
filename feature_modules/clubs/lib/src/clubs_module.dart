import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/clubs.dart';
import 'package:get_it/get_it.dart';

import 'application/usecases/delete_cached_clubs_usecase.dart';
import 'application/usecases/get_clubs_usecase.dart';
import 'domain/interface/clubs_repository_interface.dart';
import 'infrastructure/primary/routes/clubs_router.dart';
import 'infrastructure/secondary/data/api/clubs_api_client.dart';
import 'infrastructure/secondary/data/storage/clubs_storage.dart';
import 'infrastructure/secondary/repository/clubs_repository.dart';

class ClubsModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, LocalizedDataContainigAppModule {
  @override
  String get moduleName => 'ClubsModule';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final clubsStorage = ClubsStorage();
    final clubsRepository = ClubsRepository(ClubsApiClient(baseApiClient), clubsStorage);
    final getClubsUseCase = GetClubsUsecase(clubsRepository);
    final deleteCachedClubsUsecase = DeleteCachedClubsUsecase(clubsRepository);

    GetIt.I.registerSingleton<ClubsRepositoryInterface>(clubsRepository);
    GetIt.I.registerSingleton<GetClubsUsecase>(getClubsUseCase);
    GetIt.I.registerSingleton<DeleteCachedClubsUsecase>(deleteCachedClubsUsecase);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<ClubsRouter>(ClubsRouterImpl());
  }

  @override
  void onLocaleChange() {
    GetIt.I.get<DeleteCachedClubsUsecase>().call();
  }
}
