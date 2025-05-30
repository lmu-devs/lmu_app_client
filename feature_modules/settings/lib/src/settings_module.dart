import 'package:core/module.dart';
import 'package:core_routes/settings.dart';
import 'package:get_it/get_it.dart';

import 'routes/settings_router.dart';

class SettingsModule extends AppModule with PublicApiProvidingAppModule {
  @override
  String get moduleName => 'SettingsModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<SettingsRouter>(SettingsRouterImpl());
  }
}
