import 'package:core/module.dart';
import 'package:get_it/get_it.dart';

import 'public_api/public_api.dart';
import 'repository/repository.dart';

class MensaModule extends AppModule
    with LocalDependenciesProvidingAppModule, NoticeableAppStartAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'MensaModule';

  @override
  void provideLocalDependcies() {
    GetIt.I.registerSingleton<MensaRepository>(
      ConnectedMensaRepository(
        mensaApiClient: MensaApiClient(),
      ),
    );
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<MensaPublicApi>(
      DefaultMensaPublicApi(),
    );
  }

  @override
  void onAppStartNotice() {}
}
