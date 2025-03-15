import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/mensa.dart';

import 'bloc/bloc.dart';
import 'repository/repository.dart';
import 'services/default_mensa_service.dart';
import 'services/services.dart';

class MensaModule extends AppModule
    with
        LocalDependenciesProvidingAppModule,
        PublicApiProvidingAppModule,
        PrivateDataContainingAppModule,
        LocalizedDataContainigAppModule {
  @override
  String get moduleName => 'MensaModule';

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<MensaRepository>(ConnectedMensaRepository(mensaApiClient: MensaApiClient()));
    GetIt.I.registerSingleton<MensaCubit>(MensaCubit(), dispose: (srv) => srv.close());
    GetIt.I.registerSingleton<TasteProfileService>(TasteProfileService(), dispose: (srv) => srv.dispose());
    GetIt.I.registerSingleton<TasteProfileCubit>(TasteProfileCubit(), dispose: (srv) => srv.close());
    GetIt.I
        .registerSingleton<MensaUserPreferencesService>(MensaUserPreferencesService(), dispose: (srv) => srv.dispose());
    GetIt.I.registerSingleton<MenuService>(MenuService(), dispose: (srv) => srv.dispose());
    GetIt.I.registerSingleton<MensaStatusUpdateService>(MensaStatusUpdateService(), dispose: (srv) => srv.dispose());
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<MensaService>(DefaultMensaService());
  }

  @override
  void onDeletePrivateData() {
    GetIt.I.get<MensaUserPreferencesService>().reset();
  }

  @override
  void onLocaleChange() {
    GetIt.I.get<MenuService>().dispose();
    GetIt.I.get<TasteProfileCubit>().resetTasteProfile();
  }
}
