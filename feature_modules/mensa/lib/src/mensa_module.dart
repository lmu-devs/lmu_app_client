import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';

import 'bloc/bloc.dart';
import 'public_api/default_mensa_public_api.dart';
import 'public_api/public_api.dart';
import 'repository/repository.dart';
import 'services/services.dart';

class MensaModule extends AppModule
    with
        LocalDependenciesProvidingAppModule,
        NoticeableAppStartAppModule,
        PublicApiProvidingAppModule,
        WaitingAppStartAppModule,
        PrivateDataContainingAppModule {
  @override
  String get moduleName => 'MensaModule';

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<MensaRepository>(
      ConnectedMensaRepository(
        mensaApiClient: MensaApiClient(),
        userService: GetIt.I.get<UserService>(),
      ),
    );
    GetIt.I.registerSingleton<MensaCubit>(MensaCubit(), dispose: (srv) => srv.close());
    GetIt.I.registerSingleton<TasteProfileService>(TasteProfileService());
    GetIt.I.registerSingleton<TasteProfileCubit>(TasteProfileCubit(), dispose: (srv) => srv.close());
    GetIt.I.registerSingleton<MensaUserPreferencesService>(MensaUserPreferencesService());
    GetIt.I.registerSingleton<MenuService>(MenuService(), dispose: (srv) => srv.dispose());
    GetIt.I.registerSingleton<MensaDistanceService>(MensaDistanceService(), dispose: (srv) => srv.dispose());
    GetIt.I.registerSingleton<MensaStatusUpdateService>(MensaStatusUpdateService(), dispose: (srv) => srv.dispose());
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<MensaPublicApi>(DefaultMensaPublicApi());
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<MensaCubit>().loadMensaData();
    GetIt.I.get<TasteProfileCubit>().loadTasteProfile();
    GetIt.I.get<TasteProfileService>().init();
    GetIt.I.get<MensaDistanceService>().init();
    GetIt.I.get<MensaStatusUpdateService>().init();
  }

  @override
  Future onAppStartWaiting() async {
    await GetIt.I.get<MensaUserPreferencesService>().init();
  }

  @override
  void onDeletePrivateData() {
    GetIt.I.get<MensaUserPreferencesService>().reset();
  }
}
