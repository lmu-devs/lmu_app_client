import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/roomfinder.dart';

import 'cubit/roomfinder_cubit/cubit.dart';
import 'repository/api/roomfinder_api_client.dart';
import 'repository/roomfinder_repository.dart';
import 'services/roomfinder_filter_service.dart';
import 'services/roomfinder_search_service.dart';
import 'services/services.dart';

class RoomfinderModule extends AppModule
    with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule, NoticeableAppStartAppModule {
  @override
  String get moduleName => 'RoomfinderModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<RoomfinderService>(DefaultRoomfinderService());
  }

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<RoomfinderRepository>(RoomfinderRepository(roomfinderApiClient: RoomfinderApiClient()));
    GetIt.I.registerSingleton<RoomfinderCubit>(RoomfinderCubit());
    GetIt.I
        .registerSingleton<RoomfinderFavoritesService>(RoomfinderFavoritesService(), dispose: (srv) => srv.dispose());
    GetIt.I.registerSingleton<RoomfinderFilterService>(RoomfinderFilterService(), dispose: (srv) => srv.dispose());
    GetIt.I.registerSingleton<RoomfinderSearchService>(RoomfinderSearchService());
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<RoomfinderFavoritesService>().init();
    GetIt.I.get<RoomfinderFilterService>().init();
    GetIt.I.get<RoomfinderSearchService>().init();
  }
}
