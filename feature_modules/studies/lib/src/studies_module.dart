import 'package:core/module.dart';
import 'package:core_routes/studies.dart';
import 'package:get_it/get_it.dart';

import 'infrastructure/primary/router/studies_router.dart';

class StudiesModule extends AppModule with PublicApiProvidingAppModule {
  @override
  String get moduleName => 'StudiesModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<StudiesRouter>(StudiesRouterImpl());
  }
}
