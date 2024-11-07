import 'package:core/module.dart';
import 'package:get_it/get_it.dart';

import 'bloc/bloc.dart';
import 'public_api/default_mensa_public_api.dart';
import 'public_api/public_api.dart';
import 'repository/repository.dart';
import 'services/taste_profile_service.dart';

class MensaModule extends AppModule
    with LocalDependenciesProvidingAppModule, NoticeableAppStartAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'MensaModule';

  @override
  void provideLocalDependcies() {
    final repository = ConnectedMensaRepository(
      mensaApiClient: MensaApiClient(),
    );
    GetIt.I.registerSingleton<MensaRepository>(
      repository,
    );
    GetIt.I.registerSingleton<MensaCubit>(
      MensaCubit(mensaRepository: repository),
    );
    GetIt.I.registerSingleton<MensaFavoriteCubit>(
      MensaFavoriteCubit(mensaRepository: repository),
    );

    GetIt.I.registerSingleton<TasteProfileService>(
      TasteProfileService(mensaRepository: repository),
    );
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<MensaPublicApi>(
      DefaultMensaPublicApi(),
    );
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<MensaCubit>().loadMensaData();
    GetIt.I.get<TasteProfileService>().loadTasteProfile();
  }
}
