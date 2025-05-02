import 'package:core/module.dart';
import 'package:core_routes/explore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import 'repository/explore_repository.dart';
import 'routes/explore_router.dart';
import 'services/services.dart';

class ExploreModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, NoticeableAppStartAppModule {
  @override
  String get moduleName => 'ExploreModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<ExploreService>(DefaultExploreService());
    GetIt.I.registerSingleton<ExploreRouter>(ExploreRouterImpl());
  }

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<ExploreRepository>(ExploreRepository());
    GetIt.I.registerSingleton<ExploreLocationService>(ExploreLocationService());
    GetIt.I.registerSingleton<ExploreMapService>(ExploreMapService());
    GetIt.I.registerSingleton<ExploreSearchService>(ExploreSearchService());
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<ExploreSearchService>().init();
  }
}
