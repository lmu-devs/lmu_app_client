import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/settings.dart';

import 'services/default_settings_service.dart';

class SettingsModule extends AppModule with PublicApiProvidingAppModule {
  @override
  String get moduleName => 'SettingsModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<SettingsService>(DefaultSettingsService());
  }
}
