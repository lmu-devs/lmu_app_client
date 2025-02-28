import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';

import 'repository/api/api.dart';
import 'repository/cinema_repository.dart';
import 'services/cinema_user_preference_service.dart';
import 'services/default_cinema_service.dart';
import 'cubit/cubit.dart';

class CinemaModule extends AppModule
    with
        LocalDependenciesProvidingAppModule,
        NoticeableAppStartAppModule,
        PublicApiProvidingAppModule,
        PrivateDataContainingAppModule {
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
    GetIt.I.registerSingleton<CinemaUserPreferenceService>(CinemaUserPreferenceService());
  }

  @override
  void onAppStartNotice() async {
    await GetIt.I.get<CinemaUserPreferenceService>().init();
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<CinemaService>(DefaultCinemaService());
  }

  @override
  void onDeletePrivateData() {
    GetIt.I.get<CinemaUserPreferenceService>().reset();
  }
}
