import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/sports.dart';

import 'cubit/sports_cubit/cubit.dart';
import 'repository/repository.dart';
import 'services/default_sports_service.dart';

class SportsModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
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
  }
}
