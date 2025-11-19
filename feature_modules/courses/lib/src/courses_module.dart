import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core_routes/courses.dart';
import 'package:get_it/get_it.dart';

import 'application/usecase/get_courses_usecase.dart';
import 'application/usecase/favorite_courses_usecase.dart';
import 'application/usecase/recent_searches_usecase.dart';
import 'domain/interface/courses_repository_interface.dart';
import 'infrastructure/primary/router/courses_router.dart';
import 'infrastructure/secondary/data/api/courses_api_client.dart';
import 'infrastructure/secondary/data/storage/courses_favorites_storage.dart';
import 'infrastructure/secondary/data/storage/courses_recent_searches_storage.dart';
import 'infrastructure/secondary/repository/courses_repository.dart';

class CoursesModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'CoursesModule';

  @override
  void provideLocalDependencies() {
    final baseApiClient = GetIt.I.get<BaseApiClient>();
    final favoritesStorage = CoursesFavoritesStorage();
    final recentSearchesStorage = CoursesRecentSearchesStorage();
    final repository = CoursesRepository(CoursesApiClient(baseApiClient));
    final getUsecase = GetCoursesUsecase(repository);
    final favoritesUsecase = FavoriteCoursesUsecase(favoritesStorage);
    final recentSearchesUsecase = RecentSearchesUsecase(recentSearchesStorage, getUsecase);

    GetIt.I.registerSingleton<CoursesFavoritesStorage>(favoritesStorage);
    GetIt.I.registerSingleton<CoursesRecentSearchesStorage>(recentSearchesStorage);
    GetIt.I.registerSingleton<CoursesRepositoryInterface>(repository);
    GetIt.I.registerSingleton<GetCoursesUsecase>(getUsecase);
    GetIt.I.registerSingleton<FavoriteCoursesUsecase>(favoritesUsecase);
    GetIt.I.registerSingleton<RecentSearchesUsecase>(recentSearchesUsecase);
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<CoursesRouter>(CoursesRouterImpl());
  }
}
