import 'package:core/module.dart';
import 'package:core_routes/home.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/home.dart';

import 'bloc/home_cubit.dart';
import 'bloc/links/links.dart';
import 'repository/api/home_api_client.dart';
import 'repository/repository.dart';
import 'routes/home_router.dart';
import 'service/links_search_service.dart';
import 'service/services.dart';

class HomeModule extends AppModule
    with
        LocalDependenciesProvidingAppModule,
        NoticeableAppStartAppModule,
        PublicApiProvidingAppModule,
        PrivateDataContainingAppModule {
  @override
  String get moduleName => 'HomeModule';

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<HomeRepository>(HomeRepository(homeApiClient: HomeApiClient()));
    GetIt.I.registerSingleton<HomeCubit>(HomeCubit(homeRepository: GetIt.I.get<HomeRepository>()));
    GetIt.I.registerSingleton<LinksCubit>(LinksCubit());
    GetIt.I.registerSingleton<HomePreferencesService>(HomePreferencesService());
    GetIt.I.registerSingleton<LinksSearchService>(LinksSearchService());
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<HomePreferencesService>().init();
    GetIt.I.get<HomeCubit>().loadHomeData();
    GetIt.I.get<LinksCubit>().getLinks();
    GetIt.I.get<LinksSearchService>().init();
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<HomeService>(DefaultHomeService());
    GetIt.I.registerSingleton<HomeRouter>(HomeRouterImpl());
  }

  @override
  void onDeletePrivateData() {
    GetIt.I.get<HomePreferencesService>().reset();
  }
}
