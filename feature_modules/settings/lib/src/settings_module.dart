import 'package:core/module.dart';
import 'package:core_routes/settings.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/settings.dart';

import 'api/safari_api.dart';
import 'repository/safari_repository.dart';
import 'repository/storage/safari_storage.dart';
import 'routes/settings_router.dart';
import 'usecase/safari_usecase.dart';

class SettingsModule extends AppModule
    with
        PublicApiProvidingAppModule,
        LocalDependenciesProvidingAppModule,
        NoticeableAppStartAppModule,
        PrivateDataContainingAppModule {
  @override
  String get moduleName => 'SettingsModule';

  @override
  void providePublicApi() {
    final safariUsecase = GetIt.I.get<SafariUsecase>();
    GetIt.I.registerSingleton<SafariApi>(SafariApiImpl(safariUsecase));
    GetIt.I.registerSingleton<SettingsRouter>(SettingsRouterImpl());
  }

  @override
  void provideLocalDependencies() {
    final safariRepository = SafariRepository(SafariStorage());
    GetIt.I.registerSingleton<SafariRepository>(safariRepository);
    GetIt.I.registerSingleton<SafariUsecase>(SafariUsecase(safariRepository));
  }

  @override
  void onAppStartNotice() {
    final safariUsecase = GetIt.I.get<SafariUsecase>();
    safariUsecase.loadAnimalsSeen();
  }

  @override
  void onDeletePrivateData() {
    final safariUsecase = GetIt.I.get<SafariUsecase>();
    safariUsecase.reset();
  }
}
