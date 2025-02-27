import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/home.dart';

import 'bloc/benefits/benefits.dart';
import 'bloc/home_cubit.dart';
import 'bloc/links/links.dart';
import 'repository/api/home_api_client.dart';
import 'repository/repository.dart';
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
    GetIt.I.registerSingleton<HomeRepository>(ConnectedHomeRepository(homeApiClient: HomeApiClient()));
    GetIt.I.registerSingleton<HomeCubit>(HomeCubit(homeRepository: GetIt.I.get<HomeRepository>()));
    GetIt.I.registerSingleton<LinksCubit>(LinksCubit());
    GetIt.I.registerSingleton<BenefitsCubit>(BenefitsCubit());
    GetIt.I.registerSingleton<HomePreferencesService>(HomePreferencesService());
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<HomePreferencesService>().init();
    GetIt.I.get<HomeCubit>().loadHomeData();
    GetIt.I.get<LinksCubit>().getLinks();
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<HomeService>(DefaultHomeService());
  }

  @override
  void onDeletePrivateData() {
    GetIt.I.get<HomePreferencesService>().reset();
  }
}
