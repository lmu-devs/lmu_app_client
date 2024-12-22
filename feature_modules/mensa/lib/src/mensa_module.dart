import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';

import 'bloc/bloc.dart';
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
    GetIt.I.registerSingleton<MensaRepository>(
      ConnectedMensaRepository(
        mensaApiClient: MensaApiClient(),
        userService: GetIt.I.get<UserService>(),
      ),
    );
    GetIt.I.registerSingleton<MensaCubit>(MensaCubit());
    GetIt.I.registerSingleton<TasteProfileService>(TasteProfileService());
    GetIt.I.registerSingleton<TasteProfileCubit>(TasteProfileCubit());
    GetIt.I.registerSingleton<MensaUserPreferencesService>(MensaUserPreferencesService());
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
