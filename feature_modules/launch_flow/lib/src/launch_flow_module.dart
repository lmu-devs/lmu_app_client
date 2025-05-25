import 'package:core/module.dart';
import 'package:core_routes/launch_flow.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/launch_flow.dart';

import 'application/usecase/should_show_welcome_page_usecase.dart';
import 'application/usecase/showed_welcome_page_usecase.dart';
import 'domain/interface/launch_flow_repository_interface.dart';
import 'infrastructure/primary/api/launch_flow_api.dart';
import 'infrastructure/primary/router/launch_flow_router.dart';
import 'infrastructure/secondary/data/storage/launch_flow_storage.dart';
import 'infrastructure/secondary/repository/launch_flow_repository.dart';

class LaunchFlowModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, WaitingAppStartAppModule {
  @override
  String get moduleName => 'LaunchFlowModule';

  @override
  void provideLocalDependencies() {
    final launchFlowStorage = LaunchFlowStorage();
    final launchFlowRepository = LaunchFlowRepository(launchFlowStorage);

    GetIt.I.registerSingleton<LaunchFlowRepositoryInterface>(launchFlowRepository);
  }

  @override
  void providePublicApi() {
    final repo = GetIt.I.get<LaunchFlowRepositoryInterface>();

    final showedWelcomePageUsecase = ShowedWelcomePageUsecase(repo);
    final shouldShowWelcomePageUsecase = ShouldShowWelcomePageUsecase(repo);
    GetIt.I.registerSingleton<LaunchFlowApi>(LaunchFlowApiImpl(shouldShowWelcomePageUsecase, showedWelcomePageUsecase));
    GetIt.I.registerSingleton<LaunchFlowRouter>(LaunchFlowRouterImpl());
  }

  @override
  Future onAppStartWaiting() {
    return GetIt.I.get<LaunchFlowApi>().init();
  }
}
