import 'package:core/api.dart';
import 'package:core/core_services.dart';
import 'package:core/module.dart';
import 'package:core_routes/launch_flow.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/launch_flow.dart';
import 'package:shared_api/studies.dart';

import 'application/usecase/get_feature_flags_usecase.dart';
import 'application/usecase/get_release_notes_usecase.dart';
import 'domain/interface/feature_toggle_repository_interface.dart';
import 'domain/interface/launch_flow_repository_interface.dart';
import 'domain/interface/release_notes_repository_interface.dart';
import 'infrastructure/primary/api/feature_toggle_api.dart';
import 'infrastructure/primary/api/launch_flow_api.dart';
import 'infrastructure/primary/router/launch_flow_router.dart';
import 'infrastructure/secondary/data/api/feature_toggle_api_client.dart';
import 'infrastructure/secondary/data/api/release_notes_api_client.dart';
import 'infrastructure/secondary/data/storage/feature_toggle_storage.dart';
import 'infrastructure/secondary/data/storage/launch_flow_storage.dart';
import 'infrastructure/secondary/data/storage/release_notes_storage.dart';
import 'infrastructure/secondary/repository/feature_toggle_repository.dart';
import 'infrastructure/secondary/repository/launch_flow_repository.dart';
import 'infrastructure/secondary/repository/release_notes_repository.dart';

class LaunchFlowModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, WaitingAppStartAppModule {
  @override
  String get moduleName => 'LaunchFlowModule';

  @override
  void provideLocalDependencies() {
    final appVersion = GetIt.I.get<SystemInfoService>().systemInfo.appVersion;
    final baseApiClient = GetIt.I.get<BaseApiClient>();

    final launchFlowRepository = LaunchFlowRepository(LaunchFlowStorage());
    final releaseNotesRepository = ReleaseNotesRepository(
      ReleaseNotesApiClient(baseApiClient),
      ReleaseNotesStorage(),
      appVersion,
    );
    final featureFlagsRepository = FeatureToggleRepository(
      FeatureToggleApiClient(baseApiClient),
      FeatureToggleStorage(),
      appVersion,
    );

    final getReleaseNotesUsecase = GetReleaseNotesUsecase(releaseNotesRepository);
    final getFeatureFlagsUsecase = GetFeatureFlagsUsecase(featureFlagsRepository);

    GetIt.I.registerSingleton<GetReleaseNotesUsecase>(getReleaseNotesUsecase);
    GetIt.I.registerSingleton<GetFeatureFlagsUsecase>(getFeatureFlagsUsecase);
    GetIt.I.registerSingleton<LaunchFlowRepositoryInterface>(launchFlowRepository);
    GetIt.I.registerSingleton<ReleaseNotesRepositoryInterface>(releaseNotesRepository);
    GetIt.I.registerSingleton<FeatureToggleRepositoryInterface>(featureFlagsRepository);
  }

  @override
  void providePublicApi() {
    final getFeatureFlagsUsecase = GetIt.I.get<GetFeatureFlagsUsecase>();
    GetIt.I.registerSingleton<LaunchFlowApi>(LaunchFlowApiImpl(
      GetIt.I.get<LaunchFlowRepositoryInterface>(),
      GetIt.I.get<GetReleaseNotesUsecase>(),
      getFeatureFlagsUsecase,
      GetIt.I.get<FacultiesApi>(),
    ));
    GetIt.I.registerSingleton<LaunchFlowRouter>(LaunchFlowRouterImpl());
    GetIt.I.registerSingleton<FeatureToggleApi>(FeatureToggleApiImpl(getFeatureFlagsUsecase));
  }

  @override
  Future onAppStartWaiting() {
    return GetIt.I.get<LaunchFlowApi>().init();
  }
}
