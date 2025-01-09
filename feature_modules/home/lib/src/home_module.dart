import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:home/src/service/default_home_service.dart';
import 'package:shared_api/home.dart';

class HomeModule extends AppModule with PublicApiProvidingAppModule {
  @override
  String get moduleName => 'HomeModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<HomeService>(DefaultHomeService());
  }
}
