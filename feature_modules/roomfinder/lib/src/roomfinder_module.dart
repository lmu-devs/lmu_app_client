import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/roomfinder.dart';

import 'cubit/roomfinder_cubit/cubit.dart';
import 'repository/api/roomfinder_api_client.dart';
import 'repository/roomfinder_repository.dart';
import 'services/default_roomfinder_service.dart';

class RoomfinderModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
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
  }
}
