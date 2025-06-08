import 'package:core/api.dart';
import 'package:core/core_services.dart';
import 'package:core/themes.dart';
import 'package:get_it/get_it.dart';

class GlobalRegistryManager {
  static Future<void> register() async {
    GetIt.I.registerSingleton<ThemeProvider>(ThemeProvider());
    GetIt.I.registerSingleton<LocationService>(LocationService());

    final systemInfoService = GetIt.I.registerSingleton<SystemInfoService>(SystemInfoService());
    await systemInfoService.init();

    final languageProvider = GetIt.I.registerSingleton<LanguageProvider>(LanguageProvider());
    await languageProvider.init();

    final baseApiClient = GetIt.I.registerSingleton<BaseApiClient>(DefaultBaseApiClient());
    baseApiClient.locale = languageProvider.locale;

    final featureToggleService = DefaultFeatureToggleService(baseApiClient, systemInfoService.systemInfo.appVersion);
    GetIt.I.registerSingleton<FeatureToggleService>(featureToggleService);
    await featureToggleService.init();
  }
}
