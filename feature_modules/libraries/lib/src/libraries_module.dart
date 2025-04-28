import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/libraries.dart';

import 'repository/api/api.dart';
import 'repository/libraries_repository.dart';
import 'services/libraries_user_preference_service.dart';
import 'services/default_libraries_service.dart';
import 'cubit/cubit.dart';

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
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<LibrariesUserPreferenceService>();
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<LibrariesService>(DefaultLibrariesService());
  }

  @override
  void onDeletePrivateData() {
    GetIt.I.get<LibrariesUserPreferenceService>().reset();
  }
}
