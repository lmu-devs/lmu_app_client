import 'package:core/api.dart';
import 'package:core/core_services.dart';
import 'package:core/themes.dart';
import 'package:get_it/get_it.dart';

class GlobalRegistryManager {
  static Future<void> register() async {
    GetIt.I.registerSingleton<LocationService>(LocationService());

    final systemInfoService = GetIt.I.registerSingleton<SystemInfoService>(SystemInfoService());
    await systemInfoService.init();

    final themeProvider = GetIt.I.registerSingleton<ThemeProvider>(ThemeProvider());
    final languageProvider = GetIt.I.registerSingleton<LanguageProvider>(LanguageProvider());
    await languageProvider.init();

    final baseApiClient = GetIt.I.registerSingleton<BaseApiClient>(DefaultBaseApiClient());
    baseApiClient.locale = languageProvider.locale;

    final pushNotificationsClient = GetIt.I.registerSingleton<PushNotificationsClient>(DefaultPushNotificationsClient());
    await pushNotificationsClient.init();

    final notificationsUserPreferenceService = NotificationsUserPreferenceService();
    await notificationsUserPreferenceService.refreshStatus();
    GetIt.I.registerSingleton<NotificationsUserPreferenceService>(notificationsUserPreferenceService);

    final analyticsClient = GetIt.I.registerSingleton<AnalyticsClient>(DefaultAnalyticsClient());
    analyticsClient.init(
      osVersion: systemInfoService.systemInfo.systemVersion,
      appVersion: systemInfoService.systemInfo.appVersion,
      locale: languageProvider.locale.languageCode,
      theme: themeProvider.themeMode.name,
    );

    final analyticsUserPreferenceService = AnalyticsUserPreferenceService();
    await analyticsUserPreferenceService.init();
    GetIt.I.registerSingleton<AnalyticsUserPreferenceService>(analyticsUserPreferenceService);
  }
}
