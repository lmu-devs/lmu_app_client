import 'package:core/module.dart';
import 'package:get_it/get_it.dart';

import 'bloc/bloc.dart';
import 'bloc/taste_profile/taste_profile_cubit.dart';
import 'public_api/default_mensa_public_api.dart';
import 'public_api/public_api.dart';
import 'repository/repository.dart';
import 'services/mensa_user_preferences_service.dart';
import 'services/menu_service.dart';
import 'services/taste_profile_service.dart';

class MensaModule extends AppModule
    with
        LocalDependenciesProvidingAppModule,
        NoticeableAppStartAppModule,
        PublicApiProvidingAppModule,
        WaitingAppStartAppModule {
  @override
  String get moduleName => 'MensaModule';

  @override
  void provideLocalDependencies() {
    final repository = ConnectedMensaRepository(mensaApiClient: MensaApiClient());

    GetIt.I.registerSingleton<MensaRepository>(repository);
    GetIt.I.registerSingleton<MensaCubit>(MensaCubit(mensaRepository: repository));
    GetIt.I.registerSingleton<TasteProfileService>(TasteProfileService(mensaRepository: repository));
    GetIt.I.registerSingleton<TasteProfileCubit>(TasteProfileCubit());
    GetIt.I.registerSingleton<MensaUserPreferencesService>(MensaUserPreferencesService(mensaRepository: repository));
    GetIt.I.registerSingleton<MenuService>(MenuService());
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
  }

  @override
  Future onAppStartWaiting() async {
    await GetIt.I.get<MensaUserPreferencesService>().init();
  }
}
