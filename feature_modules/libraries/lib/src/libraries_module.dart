import 'package:core/module.dart';
import 'package:core_routes/libraries.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/libraries.dart';

import 'cubit/cubit.dart';
import 'repository/api/api.dart';
import 'repository/libraries_repository.dart';
import 'services/libraries_search_service.dart';
import 'services/libraries_status_update_service.dart';
import 'services/libraries_user_preference_service.dart';
import 'routes/libraries_router.dart';
import 'services/default_libraries_service.dart';

class LibrariesModule extends AppModule
    with
        LocalDependenciesProvidingAppModule,
        NoticeableAppStartAppModule,
        PublicApiProvidingAppModule,
        PrivateDataContainingAppModule {
  @override
  String get moduleName => 'LibrariesModule';

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<LibrariesRepository>(
      ConnectedLibrariesRepository(
        librariesApiClient: LibrariesApiClient(),
      ),
    );

    GetIt.I.registerSingleton<LibrariesCubit>(LibrariesCubit());
    GetIt.I.registerSingleton<LibrariesUserPreferenceService>(LibrariesUserPreferenceService());
    GetIt.I.registerSingleton<LibrariesStatusUpdateService>(LibrariesStatusUpdateService());
    GetIt.I.registerSingleton<LibrariesSearchService>(LibrariesSearchService(), dispose: (srv) => srv.dispose()).init();
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<LibrariesUserPreferenceService>();
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<LibrariesService>(DefaultLibrariesService());
    GetIt.I.registerSingleton<LibrariesRouter>(LibrariesRouterImpl());
  }

  @override
  void onDeletePrivateData() {
    GetIt.I.get<LibrariesUserPreferenceService>().reset();
  }
}
