import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:core/themes.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';

import 'global_registry_manager.dart';

class ModuleRegistry {
  const ModuleRegistry({required this.modules});

  final List<AppModule> modules;

  Future<void> init() async {
    await GlobalRegistryManager.register();

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

    final languageProvider = GetIt.I.get<LanguageProvider>();
    languageProvider.addListener(() {
      for (final localizedDataContainingModule in modules.whereType<LocalizedDataContainigAppModule>()) {
        localizedDataContainingModule.onLocaleChange();
        GetIt.I.get<BaseApiClient>().locale = languageProvider.locale;
      }
    });
  }
}
