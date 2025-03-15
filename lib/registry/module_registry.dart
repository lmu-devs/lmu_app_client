import 'package:core/api.dart';
import 'package:core/core_services.dart';
import 'package:core/module.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';

class ModuleRegistry {
  const ModuleRegistry({required this.modules});

  final List<AppModule> modules;

  Future<void> init() async {
    String appName = await PackageInfoUtil().getAppName();
    String appVersion = await PackageInfoUtil().getAppVersion();
    String systemVersion = await DeviceInfoUtil().getOSVersion();
    GetIt.I.registerSingleton<String>(appName, instanceName: 'appName');
    GetIt.I.registerSingleton<String>(appVersion, instanceName: 'appVersion');
    GetIt.I.registerSingleton<String>(systemVersion, instanceName: 'systemVersion');
    GetIt.I.registerSingleton<ThemeProvider>(ThemeProvider());
    final baseApiClient = GetIt.I.registerSingleton<BaseApiClient>(DefaultBaseApiClient());
    final languageProvider = GetIt.I.registerSingleton<LanguageProvider>(LanguageProvider());
    GetIt.I.registerSingleton<LocationService>(LocationService(), dispose: (srv) => srv.dispose());

    await languageProvider.init();
    baseApiClient.locale = languageProvider.locale;

    final priorityDependenciesModule = modules.whereType<PriorityDependenciesProvidingAppModule>();
    for (final priorityDependencyModule in priorityDependenciesModule) {
      await priorityDependencyModule.providePriorityDependencies();
    }

    final localDependenciesModules = modules.whereType<LocalDependenciesProvidingAppModule>();
    for (final localDependencyModule in localDependenciesModules) {
      localDependencyModule.provideLocalDependencies();
    }

    final publicApiModules = modules.whereType<PublicApiProvidingAppModule>();
    for (final publicApiModule in publicApiModules) {
      publicApiModule.providePublicApi();
    }

    final noticeableAppStartModules = modules.whereType<NoticeableAppStartAppModule>();
    for (final noticeableAppStartModule in noticeableAppStartModules) {
      noticeableAppStartModule.onAppStartNotice();
    }

    final waitingAppStartModules = modules.whereType<WaitingAppStartAppModule>();
    for (final waitingAppStartModule in waitingAppStartModules) {
      await waitingAppStartModule.onAppStartWaiting();
    }

    final userService = GetIt.I.get<UserService>();
    final privateDataContainingModules = modules.whereType<PrivateDataContainingAppModule>();
    userService.deletePrivateDataStream.listen((_) {
      for (final privateDataContainingModule in privateDataContainingModules) {
        privateDataContainingModule.onDeletePrivateData();
      }
    });

    languageProvider.addListener(() {
      for (final localizedDataContainingModule in modules.whereType<LocalizedDataContainigAppModule>()) {
        localizedDataContainingModule.onLocaleChange();
        baseApiClient.locale = languageProvider.locale;
      }
    });
  }
}
