import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import 'services/default_explore_service.dart';

class ExploreModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'ExploreModule';

  @override
  void provideLocalDependcies() {}

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<ExploreService>(DefaultExploreService());
  }
}
