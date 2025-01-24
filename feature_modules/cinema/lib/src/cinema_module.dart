import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';

import 'repository/api/api.dart';
import 'repository/cinema_repository.dart';
import 'services/default_cinema_service.dart';
import 'cubit/cinema_cubit/cubit.dart';

class CinemaModule extends AppModule
    with LocalDependenciesProvidingAppModule, NoticeableAppStartAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'CinemaModule';

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<CinemaRepository>(
      ConnectedCinemaRepository(
        cinemaApiClient: CinemaApiClient(),
      ),
    );

    GetIt.I.registerSingleton<CinemaCubit>(CinemaCubit());
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<CinemaCubit>().loadCinemas();
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<CinemaService>(DefaultCinemaService());
  }
}
