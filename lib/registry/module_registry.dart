import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';

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

    final userService = GetIt.I.get<UserService>();
    final privateDataContainingModules = modules.whereType<PrivateDataContainingAppModule>();
    userService.deletePrivateDataStream.listen((_) {
      for (final privateDataContainingModule in privateDataContainingModules) {
        privateDataContainingModule.onDeletePrivateData();
      }
    });
  }
}
