import 'package:core/module.dart';

class ModuleRegistry {
  ModuleRegistry({
    required this.modules,
  });

  final List<AppModule> modules;

  Future init() async {
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
  }
}
