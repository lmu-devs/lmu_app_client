import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';

import 'services/default_cinema_service.dart';
import 'cubit/cinema_cubit/cubit.dart';

class CinemaModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'CinemaModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<CinemaService>(DefaultCinemaService());
  }

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<CinemaCubit>(CinemaCubit());
  }
}
