import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import 'services/services.dart';

class ExploreModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, NoticeableAppStartAppModule {
  @override
  String get moduleName => 'ExploreModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<ExploreService>(DefaultExploreService());
  }

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<ExploreMapService>(ExploreMapService());
    GetIt.I.registerSingleton<ExploreSheetService>(ExploreSheetService());
  }

  @override
  void onAppStartNotice() {
    GetIt.I<ExploreMapService>().init();
    GetIt.I<ExploreSheetService>().init();
  }
}
