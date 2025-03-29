import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/sports.dart';

import 'cubit/sports_cubit/cubit.dart';
import 'repository/repository.dart';
import 'services/services.dart';
import 'services/sports_search_service.dart';

class SportsModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, NoticeableAppStartAppModule {
  @override
  String get moduleName => 'SportsModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<SportsService>(DefaultSportsService());
  }

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<SportsApiClient>(SportsApiClient());
    GetIt.I.registerSingleton<SportsRepository>(ConnectedSportsRepository());
    GetIt.I.registerSingleton<SportsCubit>(SportsCubit());
    GetIt.I.registerSingleton<SportsStateService>(SportsStateService());
    GetIt.I.registerSingleton<SportsSearchService>(SportsSearchService());
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<SportsStateService>().init();
    GetIt.I.get<SportsSearchService>().init();
  }
}
