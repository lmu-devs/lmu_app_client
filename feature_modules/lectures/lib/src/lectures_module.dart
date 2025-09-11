import 'package:core/module.dart';
import 'package:core_routes/lectures.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/lectures.dart';

import 'application/usecase/favorite_lectures_usecase.dart';
import 'application/usecase/get_lectures_usecase.dart';
import 'domain/interface/lectures_repository_interface.dart';
import 'infrastructure/primary/api/lectures_api.dart';
import 'infrastructure/primary/router/lectures_router.dart';
import 'infrastructure/secondary/data/storage/lectures_favorites_storage.dart';
import 'infrastructure/secondary/data/storage/lectures_storage.dart';
import 'infrastructure/secondary/repository/lectures_repository.dart';

class LecturesModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'LecturesModule';

  @override
  void provideLocalDependencies() {
    final storage = LecturesStorage();
    final favoritesStorage = LecturesFavoritesStorage();
    final repository = LecturesRepository(storage);
    final favoriteUsecase = FavoriteLecturesUsecase(favoritesStorage);
    final getUsecase = GetLecturesUsecase(repository, favoriteUsecase);

    GetIt.I.registerSingleton<LecturesRepositoryInterface>(repository);
    GetIt.I.registerSingleton<GetLecturesUsecase>(getUsecase);
    GetIt.I.registerSingleton<FavoriteLecturesUsecase>(favoriteUsecase);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<LecturesApi>(LecturesApiImpl());
    GetIt.I.registerSingleton<LecturesRouter>(LecturesRouterImpl());
  }
}
