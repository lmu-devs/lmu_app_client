import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import 'cubit/cubit.dart';
import 'repository/api/explore_api_client.dart';
import 'repository/explore_repository.dart';
import 'services/services.dart';

class ExploreModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, NoticeableAppStartAppModule {
  @override
  String get moduleName => 'ExploreModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<ExploreService>(DefaultExploreService());
  }

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<ExploreRepository>(ExploreRepository(exploreApiClient: ExploreApiClient()));
    GetIt.I.registerSingleton<RoomfinderCubit>(RoomfinderCubit());
    GetIt.I.registerSingleton<ExploreMapService>(ExploreMapService());
    GetIt.I.registerSingleton<ExploreSheetService>(ExploreSheetService());
  }

  @override
  void onAppStartNotice() {
    GetIt.I<RoomfinderCubit>().loadRoomfinderLocations();
    GetIt.I<ExploreMapService>().init();
    GetIt.I<ExploreSheetService>().init();
  }
}
